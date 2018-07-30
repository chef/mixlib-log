$:.unshift File.expand_path("../lib", __FILE__)
require "mixlib/log/version"

Gem::Specification.new do |gem|
  gem.name = "mixlib-log"
  gem.version = Mixlib::Log::VERSION
  gem.summary = "A gem that provides a simple mixin for log functionality"
  gem.email = "info@chef.io"
  gem.homepage = "https://www.chef.io"
  gem.license = "Apache-2.0"
  gem.authors = ["Chef Software, Inc."]
  gem.extra_rdoc_files = ["README.md", "LICENSE", "NOTICE"]
  gem.files = Dir["lib/**/*"] + Dir["spec/**/*"] + ["Gemfile", "Rakefile", ".gemtest", "mixlib-log.gemspec"]
  gem.required_ruby_version = ">= 2.2"
end
