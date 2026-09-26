# Each example gets its own anonymous class extended with Mixlib::Log, so
# no logger state leaks between examples and the suite is safe to run in
# random order.
RSpec.shared_context "with an isolated log" do
  subject(:log) { Class.new { extend Mixlib::Log } }

  let(:io) { StringIO.new }

  after { log.reset! }
end

RSpec.configure do |config|
  config.include_context "with an isolated log", :isolated_log
end
