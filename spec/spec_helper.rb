$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'mixlib/log'
require 'mixlib/log/formatter'

class Logit
  class << self
    include Mixlib::Log
  end
end