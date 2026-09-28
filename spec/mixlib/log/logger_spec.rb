# Copyright:: Copyright (c) 2009-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

RSpec.describe Mixlib::Log::Logger do
  subject(:logger) { described_class.new(io) }

  let(:io) { StringIO.new }

  it "is a ::Logger" do
    expect(logger).to be_a(Logger)
  end

  it "uses the Mixlib formatter" do
    expect(logger.formatter).to be_a(Mixlib::Log::Formatter)
  end

  it "logs a message in text format" do
    logger.info("test message")
    expect(io.string).to match(/\A\[.+\] INFO: test message\n\z/)
  end

  it "labels each severity" do
    logger.level = Mixlib::Log::Logging::TRACE
    %i{trace debug info warn error fatal unknown}.each { |name| logger.public_send(name, name.to_s) }
    labels = io.string.lines.map { |line| line[/\] (\w+):/, 1] }
    expect(labels).to eq(%w{TRACE DEBUG INFO WARN ERROR FATAL ANY})
  end

  it "keeps the message from #unknown" do
    logger.unknown("mystery")
    expect(io.string).to match(/ANY: mystery/)
  end

  describe "#trace?" do
    it "is false above TRACE" do
      logger.level = Logger::DEBUG
      expect(logger).not_to be_trace
    end

    it "is true at TRACE" do
      logger.level = Mixlib::Log::Logging::TRACE
      expect(logger).to be_trace
    end
  end

  describe "#add" do
    it "returns true" do
      expect(logger.add(Logger::WARN, "msg")).to be(true)
    end

    it "drops messages below the level" do
      logger.level = Logger::ERROR
      expect(logger.add(Logger::WARN, "dropped")).to be(true)
      expect(io.string).to be_empty
    end

    it "treats a nil severity as UNKNOWN" do
      logger.add(nil, "msg")
      expect(io.string).to match(/ANY: msg/)
    end

    it "reads the message from a block" do
      logger.add(Logger::WARN) { "from a block" }
      expect(io.string).to match(/WARN: from a block/)
    end

    it "does not evaluate the block when the message is dropped" do
      logger.level = Logger::ERROR
      expect { |b| logger.add(Logger::WARN, &b) }.not_to yield_control
    end

    it "does not evaluate the block from a logging method when the message is dropped" do
      logger.level = Logger::ERROR
      expect { |b| logger.warn(&b) }.not_to yield_control
    end

    it "uses progname as the message when there is no message or block" do
      logger.add(Logger::WARN, nil, "from progname")
      expect(io.string).to match(/WARN: from progname/)
    end

    it "does not modify the caller's data" do
      data = { key: "value" }
      logger.add(Logger::WARN, "msg", nil, data: data)
      expect(data).to eq({ key: "value" })
    end

    it "accepts nil data" do
      logger.add(Logger::WARN, "msg", nil, data: nil)
      expect(io.string).to match(/WARN: msg/)
    end

    it "gives the formatter a new hash it can modify" do
      seen = []
      logger.formatter = proc do |_severity, _time, _progname, msg|
        msg[:seen] = true
        seen << msg
        "#{msg[:msg]}\n"
      end
      logger.warn("first")
      logger.warn("second")

      expect(seen.map(&:frozen?)).to eq([false, false])
      expect(seen.first).not_to be(seen.last)
    end

    it "formats exceptions" do
      logger.add(Logger::ERROR, IOError.new("broken pipe"))
      expect(io.string).to match(/ERROR: broken pipe \(IOError\)/)
    end
  end

  context "with a nil log device" do
    let(:io) { nil }

    it "discards messages" do
      expect(logger.add(Logger::FATAL, "nowhere")).to be(true)
    end
  end

  context "when the device fails to write" do
    before { allow(io).to receive(:write).and_raise(IOError, "disk full") }

    it "warns on stderr instead of raising" do
      expect { logger.warn("lost") }.to output(/log writing failed. disk full/).to_stderr
    end
  end

  describe "LocklessLogDevice" do
    it "turns on sync for IO objects" do
      logger
      expect(io.sync).to be(true)
    end

    it "closes the underlying IO" do
      logger.close
      expect(io).to be_closed
    end
  end
end
