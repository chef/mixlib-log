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

require "mixlib/log/logging"

module Mixlib
  module Log
    class Child
      include Mixlib::Log::Logging

      attr_reader :parent
      def initialize(parent, metadata = {})
        @parent = parent
        @metadata = metadata
      end

      def level
        parent.level
      end

      # Define the methods to interrogate the logger for the current log level.
      # Note that we *only* query the default logger (@logger) and not any other
      # loggers that may have been added, even though it is possible to configure
      # two (or more) loggers at different log levels.
      [:trace?, :debug?, :info?, :warn?, :error?, :fatal?].each do |method_name|
        class_eval(<<-METHOD_DEFN, __FILE__, __LINE__)
          def #{method_name}
            parent.send(:#{method_name})
          end
        METHOD_DEFN
      end

      def add(severity, message = nil, progname = nil, data: {}, &block)
        data = metadata.merge(data) if data.kind_of?(Hash)
        parent.send(:pass, severity, message, progname, data: data, &block)
      end

    end
  end
end
