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
require "ostruct"
require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

class LoggerLike
  attr_accessor :level
  attr_reader :messages
  def initialize(dev = STDOUT)
    @messages = ""
    @logdev = OpenStruct.new(:dev => dev)
  end

  def close
    @messages = ""
  end

  [:debug, :info, :warn, :error, :fatal].each do |method_name|
    class_eval(<<-E)
      def #{method_name}(message)
        @messages << message
      end
    E
  end
end

describe Mixlib::Log do

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

  it "should set the log level using the binding form,  with :debug, :info, :warn, :error, or :fatal" do
    levels = {
      :debug => Logger::DEBUG,
      :info  => Logger::INFO,
      :warn  => Logger::WARN,
      :error => Logger::ERROR,
      :fatal => Logger::FATAL,
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

  it "should set the log level using the method form, with :debug, :info, :warn, :error, or :fatal" do
    levels = {
      :debug => Logger::DEBUG,
      :info  => Logger::INFO,
      :warn  => Logger::WARN,
      :error => Logger::ERROR,
      :fatal => Logger::FATAL,
    }
    levels.each do |symbol, constant|
      Logit.level(symbol)
      expect(Logit.logger.level).to eq(constant)
    end
  end

  it "should raise an ArgumentError if you try and set the level to something strange using the binding form" do
    expect(lambda { Logit.level = :the_roots }).to raise_error(ArgumentError)
  end

  it "should raise an ArgumentError if you try and set the level to something strange using the method form" do
    expect(lambda { Logit.level(:the_roots) }).to raise_error(ArgumentError)
  end

  it "should pass other method calls directly to logger" do
    Logit.level = :debug
    expect(Logit).to be_debug
    expect(lambda { Logit.debug("Gimme some sugar!") }).to_not raise_error
  end

  it "should pass add method calls directly to logger" do
    logdev = StringIO.new
    Logit.init(logdev)
    Logit.level = :debug
    expect(Logit).to be_debug
    expect(lambda { Logit.add(Logger::DEBUG, "Gimme some sugar!") }).to_not raise_error
    expect(logdev.string).to match(/Gimme some sugar/)
  end

  it "should default to STDOUT if init is called with no arguments" do
    expect(Logger).to receive(:new).with(STDOUT).and_call_original
    Logit.init
  end

  it "should have by default a base log level of warn" do
    Logit.init
    expect(Logit.level).to eq(:warn)
  end

  describe "closes old loggers" do
    it "should not try to close the STDOUT logger" do
      log = LoggerLike.new(STDOUT)
      Logit.init(log)
      expect(log).to_not receive(:close)
      Logit.reset!
    end

    it "should close other loggers" do
      log = LoggerLike.new(StringIO.new)
      Logit.init(log)
      expect(log).to receive(:close)
      Logit.reset!
    end

    it "should close all loggers" do
      log1 = LoggerLike.new(StringIO.new)
      log2 = LoggerLike.new(StringIO.new)
      Logit.init
      Logit.use_log_devices([log1, log2])
      expect(log1).to receive(:close)
      expect(log2).to receive(:close)
      Logit.reset!
    end
  end
end
