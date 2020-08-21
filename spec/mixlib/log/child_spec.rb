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

require "tempfile" unless defined?(Tempfile)
require "stringio" unless defined?(StringIO)
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

  context "with structured data" do
    it "can be created with metadata" do
      expect(Logit).to receive(:pass).with(Mixlib::Log::LEVELS[:warn], "a message", nil, data: { child: "true" })
      Logit.with_child({ child: "true" }) { |l| l.warn("a message") }
    end

    it "a message can be logged" do
      expect(Logit).to receive(:pass).with(Mixlib::Log::LEVELS[:warn], "a message", nil, data: { child: "true" })
      Logit.with_child { |l| l.warn("a message", data: { child: "true" }) }
    end

    context "merges properly" do
      it "in the simple case" do
        expect(Logit).to receive(:pass).with(Mixlib::Log::LEVELS[:warn], "a message", nil, data: { child: "true", meta: "data" })
        Logit.with_child(meta: "data") { |l| l.warn("a message", data: { child: "true" }) }
      end

      it "when overwriting" do
        expect(Logit).to receive(:pass).with(Mixlib::Log::LEVELS[:warn], "a message", nil, data: { child: "true", meta: "overwritten" })
        Logit.with_child(meta: "data") { |l| l.warn("a message", data: { child: "true", meta: "overwritten" }) }
      end
    end

    context "when receiving a message from a child" do
      it "passes data on" do
        expect(Logit).to receive(:pass).with(Mixlib::Log::LEVELS[:warn], "a message", nil, data: { child: "true", parent: "first" })
        child.metadata = { parent: "first" }
        child.with_child { |l| l.warn("a message", data: { child: "true" }) }
      end

      it "merges its own data" do
        expect(Logit).to receive(:pass).with(Mixlib::Log::LEVELS[:warn], "a message", nil, data: { child: "true", parent: "second" })
        child.metadata = { parent: "first" }
        child.with_child { |l| l.warn("a message", data: { child: "true", parent: "second" }) }
      end
    end
  end

  context "sends a message to the parent" do
    %i{ debug info warn error fatal }.each do |level|
      it "at #{level}" do
        expect(Logit).to receive(:pass).with(Mixlib::Log::LEVELS[level], "a #{level} message", nil, data: {})
        Logit.level = level
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
