$:.unshift File.expand_path("../lib", __FILE__)
require "mixlib/log/version"

Gem::Specification.new do |gem|
  gem.name = "mixlib-log"
  gem.version = Mixlib::Log::VERSION
  gem.summary = "A gem that provides a simple mixin for log functionality"
  gem.email = "info@chef.io"
  gem.homepage = "https://github.com/chef/mixlib-log"
  gem.license = "Apache-2.0"
  gem.authors = ["Chef Software, Inc."]
  gem.files = %w{LICENSE} + Dir.glob("lib/**/*", File::FNM_DOTMATCH).reject { |f| File.directory?(f) }
  gem.require_paths = ["lib"]
  gem.required_ruby_version = ">= 2.3"
end
