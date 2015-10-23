$:.unshift File.expand_path('../lib', __FILE__)
require 'mixlib/log/version'

Gem::Specification.new do |gem|
  gem.name = "mixlib-log"
  gem.version = Mixlib::Log::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.summary = "A gem that provides a simple mixin for log functionality"
  gem.email = "info@opscode.com"
  gem.homepage = "http://www.opscode.com"
  gem.license = "Apache-2.0"
  gem.authors = ["Opscode, Inc."]
  gem.has_rdoc = true
  gem.extra_rdoc_files = ["README.rdoc", "LICENSE", 'NOTICE']
  gem.files = Dir['lib/**/*'] + Dir['spec/**/*'] + ["Gemfile", "Rakefile", ".gemtest", "mixlib-log.gemspec"]
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.10'
  gem.add_development_dependency 'cucumber'
end
