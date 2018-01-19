#
# Copyright:: Copyright (c) 2018 Chef Software, Inc.
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

require "logger"
require "mixlib/log/child"

module Mixlib
  module Log
    module Logging

      LEVELS = { :debug => Logger::DEBUG, :info => Logger::INFO, :warn => Logger::WARN, :error => Logger::ERROR, :fatal => Logger::FATAL }.freeze
      LEVEL_NAMES = LEVELS.invert.freeze

      attr_accessor :metadata

      def pass(severity, args, progname = nil, data: {}, &block)
        args, progname, data = yield if block_given?
        add(severity, args, progname, data: data)
      end

      # Define the standard logger methods on this class programmatically.
      # No need to incur method_missing overhead on every log call.
      [:debug, :info, :warn, :error, :fatal].each do |method_name|
        level = LEVELS[method_name]
        class_eval(<<-METHOD_DEFN, __FILE__, __LINE__)
        def #{method_name}(msg=nil, data: {}, &block)
          pass(#{level}, msg, data: data, &block)
        end
        METHOD_DEFN
      end

      def with_child(metadata = {})
        child = Child.new(self, metadata)
        if block_given?
          yield child
        else
          child
        end
      end

    end
  end
end
