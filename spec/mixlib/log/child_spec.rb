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
#

require "tempfile"
require "stringio"
require "spec_helper"

RSpec.describe Mixlib::Log::Child do
  before do
    Logit.reset!
    Logit.init(io)
    Logit.level = :warn
  end

  let(:io) { StringIO.new }

  let(:child) { Logit.with_child }

  it "has a parent" do
    expect(child.parent).to be(Logit)
  end

  it "accepts a message" do
    Logit.with_child { |l| l.add(Logger::WARN, "a message") }
    expect(io.string).to match(/a message$/)
  end

  context "sends a message to the parent" do
    %i{ debug info warn error fatal }.each do |level|
      it "at #{level}" do
        expect(Logit).to receive(:pass).with(level, "a #{level} message", nil)
        child.send(level, "a #{level} message")
      end
    end
  end

  context "can query the parent's level" do
    %i{ debug info warn error fatal }.each do |level|
      it "at #{level}" do
        query = "#{level}?".to_sym
        Logit.level = level
        expect(child.send(query)).to be(true)
      end
    end
  end
end
