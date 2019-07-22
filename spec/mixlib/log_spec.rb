#
# Author:: Adam Jacob (<adam@chef.io>)
# Author:: Christopher Brown (<cb@chef.io>)
# Copyright:: Copyright (c) 2008-2016 Chef Software, Inc.
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

require "tempfile"
require "stringio"
require "spec_helper"

class LoggerLike
  attr_accessor :level
  attr_reader :messages, :data
  def initialize
    @messages = ""
    @data = []
  end

  def add_data(severity, message = nil, progname = nil, data: {})
    @messages << message
    @data << data
  end

  def add(severity, message = nil, progname = nil, data: {})
    @messages << message
  end

  [:trace, :debug, :info, :warn, :error, :fatal].each do |method_name|
    class_eval(<<-E)
      def #{method_name}(message)
        @messages << message
      end
    E
  end
end

RSpec.describe Mixlib::Log do

  # Since we are testing class behaviour for an instance variable
  # that gets set once, we need to reset it prior to each example [cb]
  before(:each) do
    Logit.reset!
  end

  it "creates a logger using an IO object" do
    io = StringIO.new
    Logit.init(io)
    Logit << "foo"
    expect(io.string).to match(/foo/)
  end

  it "creates a logger with a file name" do
    Tempfile.open("chef-test-log") do |tempfile|
      Logit.init(tempfile.path)
      Logit << "bar"
      tempfile.rewind
      expect(tempfile.read).to match(/bar/)
    end
  end

  it "uses the logger provided when initialized with a logger like object" do
    logger = LoggerLike.new
    Logit.init(logger)
    Logit.level = :debug
    Logit.debug "qux"
    expect(logger.messages).to match(/qux/)
  end

  it "should re-initialize the logger if init is called again" do
    first_logdev, second_logdev = StringIO.new, StringIO.new
    Logit.init(first_logdev)
    Logit.fatal "FIRST"
    expect(first_logdev.string).to match(/FIRST/)
    Logit.init(second_logdev)
    Logit.fatal "SECOND"
    expect(first_logdev.string).to_not match(/SECOND/)
    expect(second_logdev.string).to match(/SECOND/)
  end

  it "knows that it's been configured" do
    Logit.init
    expect(Logit.configured?).to be true
  end

  it "should set the log level using the binding form,  with :trace, :debug, :info, :warn, :error, or :fatal" do
    levels = {
      trace: Mixlib::Log::TRACE,
      debug: Mixlib::Log::DEBUG,
      info: Mixlib::Log::INFO,
      warn: Mixlib::Log::WARN,
      error: Mixlib::Log::ERROR,
      fatal: Mixlib::Log::FATAL,
    }
    levels.each do |symbol, constant|
      Logit.level = symbol
      expect(Logit.logger.level).to eq(constant)
      expect(Logit.level).to eq(symbol)
    end
  end

  it "passes blocks to the underlying logger object" do
    logdev = StringIO.new
    Logit.init(logdev)
    Logit.fatal { "the_message" }
    expect(logdev.string).to match(/the_message/)
  end

  it "should set the log level using the method form, with :trace, :debug, :info, :warn, :error, or :fatal" do
    levels = {
      trace: Mixlib::Log::TRACE,
      debug: Mixlib::Log::DEBUG,
      info: Mixlib::Log::INFO,
      warn: Mixlib::Log::WARN,
      error: Mixlib::Log::ERROR,
      fatal: Mixlib::Log::FATAL,
    }
    levels.each do |symbol, constant|
      Logit.level(symbol)
      expect(Logit.logger.level).to eq(constant)
    end
  end

  it "should raise an ArgumentError if you try and set the level to something strange using the binding form" do
    expect { Logit.level = :the_roots }.to raise_error(ArgumentError)
  end

  it "should raise an ArgumentError if you try and set the level to something strange using the method form" do
    expect { Logit.level(:the_roots) }.to raise_error(ArgumentError)
  end

  it "should pass other method calls directly to logger" do
    expect do
      # this needs to be inside of the block because the level setting
      # is causing the init, which grabs $stderr before rspec replaces
      # it for output testing.
      Logit.level = :debug
      expect(Logit).to be_debug
      Logit.debug("Gimme some sugar!")
    end.to output(/DEBUG: Gimme some sugar!/).to_stdout
  end

  it "should pass add method calls directly to logger" do
    logdev = StringIO.new
    Logit.init(logdev)
    Logit.level = :debug
    expect(Logit).to be_debug
    expect { Logit.add(Logger::DEBUG, "Gimme some sugar!") }.to_not raise_error
    expect(logdev.string).to match(/Gimme some sugar/)
  end

  it "should default to STDOUT if init is called with no arguments" do
    logger_mock = Struct.new(:formatter, :level).new
    # intentionally STDOUT to avoid unfailable test
    expect(Logger).to receive(:new).with(STDOUT).and_return(logger_mock)
    Logit.init
  end

  it "should have by default a base log level of warn" do
    logger_mock = Struct.new(:formatter, :level).new
    expect(Logger).to receive(:new).and_return(logger_mock)
    Logit.init
    expect(Logit.level).to eq(:warn)
  end

  it "should close File logger" do
    opened_files_count_before = 0
    ObjectSpace.each_object(File) do |f|
      opened_files_count_before += 1 unless f.closed?
    end
    name = File.join(Dir.tmpdir, "logger.log")
    Logit.init(name)
    Logit.init(name)
    Logit.init(name)
    opened_files_count_after = 0
    ObjectSpace.each_object(File) do |f|
      opened_files_count_after += 1 unless f.closed?
    end
    expect(opened_files_count_after).to eq(opened_files_count_before + 1)
  end

  it "should not close IO logger" do
    opened_files_count_before = 0
    ObjectSpace.each_object(File) do |f|
      opened_files_count_before += 1 unless f.closed?
    end
    Tempfile.open("chef-test-log") do |file|
      Logit.init(file)
      Logit.init(file)
      Logit.init(file)
      opened_files_count_after = 0
      ObjectSpace.each_object(File) do |f|
        opened_files_count_after += 1 unless f.closed?
      end
      expect(opened_files_count_after).to eq(opened_files_count_before + 1)
    end
  end

  it "should return nil from its logging methods" do
    # intentionally STDOUT to avoid unfailable test
    expect(Logger).to receive(:new).with(STDOUT) { double("a-quiet-logger").as_null_object }
    Logit.init

    aggregate_failures "returns nil from logging method" do
      expect(Logit.trace("hello")).to be_nil
      expect(Logit.debug("hello")).to be_nil
      expect(Logit.info("hello")).to be_nil
      expect(Logit.warn("hello")).to be_nil
      expect(Logit.error("hello")).to be_nil
      expect(Logit.fatal("hello")).to be_nil
    end
  end

  it "should set metadata correctly" do
    Logit.metadata = { test: "data" }
    expect(Logit.metadata).to eql({ test: "data" })
  end

  it "should format :trace level messages with TRACE: label" do
    logdev = StringIO.new
    Logit.init(logdev)
    Logit.level = :trace
    Logit.trace("this is a log message")
    aggregate_failures do
      expect(logdev.string).to_not match(/ANY:/)
      expect(logdev.string).to match(/TRACE:/)
    end
  end
end
