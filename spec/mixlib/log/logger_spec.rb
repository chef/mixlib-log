# Copyright:: Copyright (c) 2024 Chef Software, Inc.
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

require "spec_helper"

RSpec.describe Mixlib::Log::Logger do
  let(:io) { StringIO.new }

  subject { described_class.new(io) }

  it "logs a info message in text format" do
    subject.info("test message")

    expect(io.string).to match(/INFO: test message/)
  end
end
