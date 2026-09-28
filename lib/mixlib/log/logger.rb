require "logger"
require_relative "logging"

# A subclass of Ruby's stdlib Logger with all the mutex and log rotation stuff
# ripped out, and metadata added in.
module Mixlib
  module Log
    class Logger < ::Logger

      include Logging

      def trace?; @level <= TRACE; end

      #
      # === Synopsis
      #
      #   Logger.new(name, shift_age = 7, shift_size = 1048576)
      #   Logger.new(name, shift_age = 'weekly')
      #
      # === Args
      #
      # +logdev+::
      #   The log device.  This is a filename (String) or IO object (typically
      #   +$stdout+, +$stderr+, or an open file).
      # +shift_age+::
      #   Number of old log files to keep, *or* frequency of rotation (+daily+,
      #   +weekly+ or +monthly+).
      # +shift_size+::
      #   Maximum logfile size (only applies when +shift_age+ is a number).
      #
      # === Description
      #
      # Create an instance.
      #
      def initialize(logdev)
        super(nil, formatter: ::Mixlib::Log::Formatter.new)
        if logdev
          @logdev = LocklessLogDevice.new(logdev)
        end
      end

      def add_data(severity, message = nil, progname = nil, data: EMPTY_DATA)
        severity ||= UNKNOWN
        return true if @logdev.nil? || severity < level

        # match ::Logger#add: with no message, use the block or else the progname
        if message.nil?
          if block_given?
            message = yield
          else
            message = progname
            progname = @progname
          end
        end

        # build a new hash so the caller's data is never modified, and skip
        # the merge entirely in the common case of no data
        entry = message.is_a?(::Exception) ? { err: message } : { msg: message }
        data = data.nil? || data.empty? ? entry : data.merge(entry)
        @logdev.write(
          format_message(to_label(severity), Time.now, progname, data)
        )
        true
      end
      alias_method :add, :add_data

      class LocklessLogDevice < LogDevice

        def initialize(log = nil)
          @dev = @filename = @shift_age = @shift_size = nil
          if log.respond_to?(:write) && log.respond_to?(:close)
            @dev = log
          else
            @dev = open_logfile(log)
            @filename = log
          end
          @dev.sync = true
        end

        def write(message)
          @dev.write(message)
        rescue Exception => ignored
          warn("log writing failed. #{ignored}")
        end

        def close
          @dev.close rescue nil
        end

        private

        def open_logfile(filename)
          if FileTest.exist?(filename)
            File.open(filename, (File::WRONLY | File::APPEND))
          else
            create_logfile(filename)
          end
        end

        def create_logfile(filename)
          logdev = File.open(filename, (File::WRONLY | File::APPEND | File::CREAT))
          add_log_header(logdev)
          logdev
        end

        def add_log_header(file)
          file.write(
            "# Logfile created on %s by %s\n" % [Time.now.to_s, Logger::ProgName]
          )
        end

      end

    end
  end
end
