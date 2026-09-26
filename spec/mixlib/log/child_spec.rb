#
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

RSpec.describe Mixlib::Log::Child, :isolated_log do
  subject(:child) { log.with_child }

  before do
    log.init(io)
    log.level = :warn
  end

  it "has a parent" do
    expect(child.parent).to be(log)
  end

  it "logs through the parent" do
    log.with_child { |l| l.add(Logger::WARN, "a message") }
    expect(io.string).to match(/WARN: a message$/)
  end

  it "returns nil from logging methods" do
    expect(child.warn("a message")).to be_nil
  end

  it "passes blocks through" do
    child.warn { "from a block" }
    expect(io.string).to match(/WARN: from a block/)
  end

  it "respects the parent's level" do
    child.info("dropped")
    expect(io.string).to be_empty
  end

  it "reports the parent's level" do
    log.level = :debug
    expect(child.level).to eq(:debug)
  end

  context "sends a message to the parent" do
    %i{trace debug info warn error fatal}.each do |level|
      it "at #{level}" do
        log.level = level
        child.public_send(level, "a #{level} message")
        expect(io.string).to match(/#{level.upcase}: a #{level} message/)
      end
    end
  end

  context "can query the parent's level" do
    %i{trace debug info warn error fatal}.each do |level|
      it "at #{level}" do
        log.level = level
        expect(child.public_send(:"#{level}?")).to be(true)
      end
    end

    it "is false below the parent's level" do
      expect(child).not_to be_info
    end
  end

  context "with structured data" do
    let(:device) { instance_spy(Mixlib::Log::Logger) }

    before { log.init(device) }

    def expect_data(data)
      expect(device).to have_received(:add_data).with(Logger::WARN, "a message", nil, data: data)
    end

    it "can be created with metadata" do
      log.with_child({ child: "true" }) { |l| l.warn("a message") }
      expect_data(child: "true")
    end

    it "logs a message with data" do
      log.with_child { |l| l.warn("a message", data: { child: "true" }) }
      expect_data(child: "true")
    end

    it "merges message data over its metadata" do
      log.with_child(meta: "data", key: "old") { |l| l.warn("a message", data: { key: "new" }) }
      expect_data(meta: "data", key: "new")
    end

    it "merges its metadata over the parent's" do
      log.metadata = { app: "test", key: "parent" }
      log.with_child(key: "child") { |l| l.warn("a message") }
      expect_data(app: "test", key: "child")
    end

    it "keeps its metadata when the message comes from a block" do
      log.with_child(meta: "data") { |l| l.warn { "a message" } }
      expect_data(meta: "data")
    end

    it "does not modify its metadata when logging" do
      metadata = { meta: "data" }
      log.with_child(metadata) { |l| l.warn("a message", data: { extra: 1 }) }
      expect(metadata).to eq({ meta: "data" })
    end

    context "when nested" do
      it "passes data up through each ancestor" do
        child.metadata = { parent: "first" }
        child.with_child { |l| l.warn("a message", data: { child: "true" }) }
        expect_data(child: "true", parent: "first")
      end

      it "lets the innermost data win" do
        child.metadata = { parent: "first" }
        child.with_child { |l| l.warn("a message", data: { child: "true", parent: "second" }) }
        expect_data(child: "true", parent: "second")
      end

      it "returns the grandchild without a block" do
        expect(child.with_child).to have_attributes(parent: child)
      end
    end
  end
end
