#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
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

require 'mixlib/log/formatter'
require 'logger'

module Mixlib
  module Log
  
    @logger = nil
    
    attr_accessor :logger #:nodoc
      
    # Use Mixlib::Log.init when you want to set up the logger manually.  Arguments to this method
    # get passed directly to Logger.new, so check out the documentation for the standard Logger class
    # to understand what to do here.
    #
    # If this method is called with no arguments, it will log to STDOUT at the :info level.
    #
    # It also configures the Logger instance it creates to use the custom Mixlib::Log::Formatter class.
    def init(*opts)
      @logger ||= (opts.empty? ? Logger.new(STDOUT) : Logger.new(*opts))
      @logger.formatter = Mixlib::Log::Formatter.new()
    end
    
    # Sets the level for the Logger object by symbol.  Valid arguments are:
    #
    #  :debug
    #  :info
    #  :warn
    #  :error
    #  :fatal
    #
    # Throws an ArgumentError if you feed it a bogus log level.
    def level(loglevel=:warn)
      init()
      level = { :debug=>Logger::DEBUG, :info=>Logger::INFO, :warn=>Logger::WARN, :error=>Logger::ERROR, :fatal=>Logger::FATAL}[loglevel]
      raise ArgumentError, "Log level must be one of :debug, :info, :warn, :error, or :fatal" if level.nil?
      @logger.level = level
    end
    
    # Passes any other method calls on directly to the underlying Logger object created with init. If
    # this method gets hit before a call to Mixlib::Logger.init has been made, it will call 
    # Mixlib::Logger.init() with no arguments.
    def method_missing(method_symbol, *args)
      init()
      @logger.send(method_symbol, *args)
    end
    
  end
end
