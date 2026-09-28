#
# Author:: Adam Jacob (<adam@chef.io>)
# Author:: Christopher Brown (<cb@chef.io>)
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

require "pathname"

RSpec.describe Mixlib::Log, :isolated_log do
  describe "#init" do
    it "logs to $stdout at :warn when called with no arguments" do
      expect do
        log.init
        log.warn("to stdout")
      end.to output(/WARN: to stdout/).to_stdout
      expect(log.level).to eq(:warn)
    end

    it "returns the new logger" do
      expect(log.init(io)).to be(log.logger)
    end

    it "logs to an IO object" do
      log.init(io)
      log << "foo"
      expect(io.string).to eq("foo")
    end

    it "sets the Mixlib formatter" do
      log.init(io)
      expect(log.logger.formatter).to be_a(Mixlib::Log::Formatter)
    end

    it "resets metadata" do
      log.init(io)
      log.metadata = { stale: true }
      log.init(io)
      expect(log.metadata).to eq({})
    end

    it "marks the log as configured" do
      expect { log.init(io) }.to change(log, :configured?).from(nil).to(true)
    end

    context "with a file path" do
      around do |example|
        Dir.mktmpdir { |dir| @dir = dir; example.run }
      end

      let(:path) { File.join(@dir, "test.log") }

      it "creates the file with a header" do
        log.init(path)
        log.warn("to a file")
        log.reset!

        expect(File.read(path)).to match(/\A# Logfile created on .+\n.*WARN: to a file\n\z/)
      end

      it "appends to an existing file without writing a new header" do
        File.write(path, "existing\n")
        log.init(path)
        log.warn("appended")
        log.reset!

        expect(File.read(path)).to match(/\Aexisting\n.*WARN: appended\n\z/)
      end

      it "accepts a Pathname" do
        log.init(Pathname.new(path))
        log.warn("pathname")
        log.reset!

        expect(File.read(path)).to match(/WARN: pathname/)
      end

      it "writes immediately rather than buffering" do
        log.init(path)
        log.warn("unbuffered")

        expect(File.read(path)).to match(/WARN: unbuffered/)
      end

      it "treats a path starting with a pipe as a file name, not a command" do
        skip "| is not valid in Windows file names" if Gem.win_platform?

        Dir.chdir(@dir) do
          log.init("|echo pwned")
          log.warn("safe")
          log.reset!

          expect(File.read("|echo pwned")).to match(/WARN: safe/)
        end
      end

      it "closes the file when re-initialized" do
        log.init(path)
        expect(log.logger).to receive(:close).and_call_original

        log.init(io)
      end
    end

    it "does not close a previous IO when re-initialized" do
      log.init(io)
      log.init(StringIO.new)
      expect(io).not_to be_closed
    end

    it "sends messages only to the newest device when re-initialized" do
      second = StringIO.new
      log.init(io)
      log.fatal("FIRST")
      log.init(second)
      log.fatal("SECOND")

      aggregate_failures do
        expect(io.string).to match(/FIRST/)
        expect(io.string).not_to match(/SECOND/)
        expect(second.string).to match(/SECOND/)
      end
    end

    context "with a Mixlib::Log::Logger" do
      let(:device) { Mixlib::Log::Logger.new(io) }

      it "uses it as is" do
        expect(log.init(device)).to be(device)
      end

      it "resets its level to :warn" do
        device.level = Logger::DEBUG
        log.init(device)
        expect(log.level).to eq(:warn)
      end
    end

    context "with a plain ::Logger" do
      let(:device) { Logger.new(io) }

      before { log.init(device) }

      it "uses it as is" do
        expect(log.logger).to be(device)
      end

      it "logs through it" do
        log.warn("plain logger")
        expect(io.string).to match(/WARN: plain logger/)
      end

      it "reports trace? from its level" do
        expect { log.level = :trace }.to change(log, :trace?).from(false).to(true)
      end
    end
  end

  describe "#logger" do
    it "initializes a $stdout logger on first use" do
      expect { log.logger.warn("lazy") }.to output(/WARN: lazy/).to_stdout
    end

    it "does not replace a configured logger" do
      log.init(io)
      expect(log.logger).to be(log.logger)
    end
  end

  describe "#logger=" do
    it "replaces the log device and clears additional loggers" do
      device = Mixlib::Log::Logger.new(io)
      log.init(StringIO.new)
      log.loggers << Mixlib::Log::Logger.new(StringIO.new)

      log.logger = device

      expect(log.loggers).to eq([device])
    end
  end

  describe "#loggers" do
    it "contains only the default logger initially" do
      log.init(io)
      expect(log.loggers).to eq([log.logger])
    end

    it "writes to every device in the list" do
      other = StringIO.new
      log.init(io)
      log.loggers << Mixlib::Log::Logger.new(other)
      log.level = :info
      log.info("everywhere")
      log << "raw"

      expect([io.string, other.string]).to all(match(/INFO: everywhere\nraw\z/))
    end
  end

  describe "#use_log_devices" do
    it "shares devices with another Mixlib::Log object" do
      other = Class.new { extend Mixlib::Log }
      other.init(io)
      log.use_log_devices(other)

      aggregate_failures do
        expect(log.logger).to be(other.logger)
        expect(log.loggers).to be(other.loggers)
        expect(log).to be_configured
      end
    end

    it "uses an array of devices, with the first as the default logger" do
      devices = [Mixlib::Log::Logger.new(io), Mixlib::Log::Logger.new(StringIO.new)]
      log.use_log_devices(devices)

      expect(log.logger).to be(devices.first)
      expect(log.loggers).to be(devices)
    end

    it "raises ArgumentError for anything else" do
      expect { log.use_log_devices("nope") }.to raise_error(ArgumentError, /You gave: "nope"/)
    end
  end

  describe "#reset!" do
    it "is safe before init" do
      expect { log.reset! }.not_to raise_error
    end

    it "clears metadata" do
      log.init(io)
      log.metadata = { stale: true }
      log.reset!
      expect(log.metadata).to eq({})
    end
  end

  describe "#level=" do
    before { log.init(io) }

    Mixlib::Log::Logging::LEVELS.each do |name, value|
      it "accepts :#{name}" do
        log.level = name
        expect(log.logger.level).to eq(value)
        expect(log.level).to eq(name)
      end
    end

    it "accepts an integer severity" do
      log.level = Logger::ERROR
      expect(log.level).to eq(:error)
    end

    it "sets the level on every device" do
      other = Mixlib::Log::Logger.new(StringIO.new)
      log.loggers << other
      log.level = :debug
      expect(other.level).to eq(Logger::DEBUG)
    end

    it "raises ArgumentError for an unknown level" do
      expect { log.level = :the_roots }.to raise_error(ArgumentError, /Log level must be one of/)
    end

    it "raises ArgumentError for a string level" do
      expect { log.level = "debug" }.to raise_error(ArgumentError)
    end
  end

  describe "#level" do
    before { log.init(io) }

    it "sets the level when given an argument" do
      log.level(:debug)
      expect(log.level).to eq(:debug)
    end

    it "raises ArgumentError for an unknown level" do
      expect { log.level(:the_roots) }.to raise_error(ArgumentError)
    end
  end

  describe "level predicates" do
    before { log.init(io) }

    {
      trace: %i{trace? debug? info? warn? error? fatal?},
      debug: %i{debug? info? warn? error? fatal?},
      info: %i{info? warn? error? fatal?},
      warn: %i{warn? error? fatal?},
      error: %i{error? fatal?},
      fatal: %i{fatal?},
    }.each do |level, enabled|
      it "at :#{level} enables only #{enabled.join(", ")}" do
        log.level = level
        predicates = %i{trace? debug? info? warn? error? fatal?}
        expect(predicates.select { |p| log.public_send(p) }).to eq(enabled)
      end
    end
  end

  describe "logging methods" do
    before { log.init(io) }

    Mixlib::Log::Logging::LEVELS.each_key do |name|
      it "writes a :#{name} message with a #{name.upcase} label at that level" do
        log.level = name
        log.public_send(name, "this goes out")
        expect(io.string).to match(/\A\[.+\] #{name.upcase}: this goes out\n\z/)
      end
    end

    it "drops messages below the current level" do
      log.level = :fatal
      %i{trace debug info warn error}.each { |name| log.public_send(name, "dropped") }
      expect(io.string).to be_empty
    end

    it "logs exceptions with their class and backtrace" do
      error = RuntimeError.new("boom")
      error.set_backtrace(["a.rb:1", "b.rb:2"])
      log.error(error)
      expect(io.string).to end_with("ERROR: boom (RuntimeError)\na.rb:1\nb.rb:2\n")
    end

    it "passes blocks through to the logger" do
      log.fatal { "from a block" }
      expect(io.string).to match(/FATAL: from a block/)
    end

    it "does not evaluate the block when the message is dropped" do
      log.level = :warn
      expect { |b| log.debug(&b) }.not_to yield_control
    end

    it "evaluates the block when any device will write the message" do
      other = StringIO.new
      verbose = Mixlib::Log::Logger.new(other)
      log.loggers << verbose
      log.level = :warn
      verbose.level = Logger::DEBUG
      log.debug { "verbose only" }

      expect(io.string).to be_empty
      expect(other.string).to match(/DEBUG: verbose only/)
    end

    it "returns nil" do
      log.level = :trace
      results = Mixlib::Log::Logging::LEVELS.keys.map { |name| log.public_send(name, "hello") }
      expect(results).to all(be_nil)
    end

    it "logs :unknown messages with an ANY label" do
      log.unknown("mystery")
      expect(io.string).to match(/ANY: mystery/)
    end
  end

  describe "#add" do
    it "logs at the given severity" do
      log.init(io)
      log.add(Logger::ERROR, "added")
      expect(io.string).to match(/ERROR: added/)
    end

    it "is aliased as #log" do
      log.init(io)
      log.log(Logger::ERROR, "logged")
      expect(io.string).to match(/ERROR: logged/)
    end

    it "returns true like ::Logger#add" do
      log.init(io)
      expect(log.add(Logger::ERROR, "added")).to be(true)
    end

    it "reads the message from a block" do
      log.init(io)
      log.add(Logger::ERROR) { "from a block" }
      expect(io.string).to match(/ERROR: from a block/)
    end

    it "does not evaluate the block when the message is dropped" do
      log.init(io)
      expect { |b| log.add(Logger::DEBUG, &b) }.not_to yield_control
    end

    it "returns true when the message is dropped" do
      log.init(io)
      expect(log.add(Logger::DEBUG, "dropped")).to be(true)
    end
  end

  context "with structured data" do
    let(:device) { instance_spy(Mixlib::Log::Logger) }

    before { log.init(device) }

    it "sends data to devices that support it" do
      log.warn("msg", data: { key: "value" })
      expect(device).to have_received(:add_data).with(Logger::WARN, "msg", nil, data: { key: "value" })
    end

    it "merges data over the log's metadata" do
      log.metadata = { app: "test", key: "default" }
      log.warn("msg", data: { key: "value" })
      expect(device).to have_received(:add_data).with(Logger::WARN, "msg", nil, data: { app: "test", key: "value" })
    end

    it "does not modify the caller's data" do
      log.metadata = { app: "test" }
      data = { key: "value" }.freeze
      log.warn("msg", data: data)
      expect(data).to eq({ key: "value" })
    end

    it "keeps metadata when the message comes from a block" do
      log.metadata = { app: "test" }
      log.warn { "msg" }
      expect(device).to have_received(:add_data).with(Logger::WARN, "msg", nil, data: { app: "test" })
    end

    it "merges data returned from a block" do
      log.metadata = { app: "test" }
      log.warn { ["msg", "prog", { key: "value" }] }
      expect(device).to have_received(:add_data).with(Logger::WARN, "msg", "prog", data: { app: "test", key: "value" })
    end

    it "skips the data path when there is no data" do
      log.add(Logger::WARN, "msg")
      expect(device).to have_received(:add).with(Logger::WARN, "msg", nil)
      expect(device).not_to have_received(:add_data)
    end

    it "sends plain messages to devices without add_data" do
      plain = instance_spy(Logger)
      log.loggers << plain
      log.warn("msg", data: { key: "value" })
      expect(plain).to have_received(:add).with(Logger::WARN, "msg", nil)
    end
  end

  describe "#metadata" do
    it "is readable after being set" do
      log.metadata = { test: "data" }
      expect(log.metadata).to eq({ test: "data" })
    end
  end

  describe "#with_child" do
    before { log.init(io) }

    it "yields a child whose parent is the log" do
      expect { |b| log.with_child(&b) }.to yield_with_args(an_object_having_attributes(parent: log))
    end

    it "returns the child without a block" do
      expect(log.with_child(meta: "data")).to have_attributes(parent: log, metadata: { meta: "data" })
    end
  end

  describe "forwarding to the logger" do
    before { log.init(io) }

    it "forwards unknown methods to every device" do
      other = Mixlib::Log::Logger.new(StringIO.new)
      log.loggers << other
      log.progname = "my-app"
      expect([log.logger.progname, other.progname]).to all(eq("my-app"))
    end

    it "returns the default logger's result" do
      log.progname = "my-app"
      expect(log.progname).to eq("my-app")
    end

    it "responds to the logger's methods" do
      expect(log).to respond_to(:progname=)
    end

    it "still raises NoMethodError for methods the logger lacks" do
      expect { log.not_a_real_method }.to raise_error(NoMethodError)
    end
  end

  describe "#respond_to?" do
    it "does not initialize a logger" do
      expect { log.respond_to?(:progname) }.not_to output.to_stdout
      expect(log).not_to be_configured
    end
  end
end
