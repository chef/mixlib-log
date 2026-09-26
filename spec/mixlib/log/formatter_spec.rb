#
# Author:: Adam Jacob (<adam@chef.io>)
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

require "time"

RSpec.describe Mixlib::Log::Formatter do
  subject(:formatter) { described_class.new }

  let(:time) { Time.new(2026, 1, 2, 3, 4, 5, "+00:00") }

  describe "#call" do
    it "prefixes the message with an ISO 8601 timestamp by default" do
      expect(formatter.call("WARN", time, "prog", "mos def")).to eq("[2026-01-02T03:04:05+00:00] WARN: mos def\n")
    end

    it "omits the timestamp when show_time is off" do
      described_class.show_time = false
      expect(formatter.call("WARN", time, "prog", "mos def")).to eq("WARN: mos def\n")
    end
  end

  describe ".show_time=" do
    it "turns the timestamp off when called with no value" do
      described_class.send(:show_time=)
      expect(formatter.call("WARN", time, nil, "msg")).to eq("WARN: msg\n")
    end
  end

  describe "#msg2str" do
    it "passes strings through" do
      expect(formatter.msg2str("nuthin new")).to eq("nuthin new")
    end

    it "formats an exception without a backtrace" do
      expect(formatter.msg2str(IOError.new("legendary roots crew"))).to eq("legendary roots crew (IOError)\n")
    end

    it "formats an exception with its backtrace" do
      error = IOError.new("legendary roots crew")
      error.set_backtrace(["a.rb:1", "b.rb:2"])
      expect(formatter.msg2str(error)).to eq("legendary roots crew (IOError)\na.rb:1\nb.rb:2")
    end

    it "inspects anything else" do
      expect(formatter.msg2str([ "black thought", "?uestlove" ])).to eq('["black thought", "?uestlove"]')
    end

    it "inspects nil" do
      expect(formatter.msg2str(nil)).to eq("nil")
    end

    context "with structured data" do
      it "uses the :msg key" do
        expect(formatter.msg2str({ msg: "nuthin new", other: 1 })).to eq("nuthin new")
      end

      it "formats the :err key" do
        expect(formatter.msg2str({ err: IOError.new("legendary roots crew") })).to eq("legendary roots crew (IOError)\n")
      end

      it "prefers :err over :msg" do
        expect(formatter.msg2str({ msg: "ignored", err: IOError.new("boom") })).to eq("boom (IOError)\n")
      end
    end
  end
end
