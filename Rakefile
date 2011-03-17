require 'rake'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'yaml'

gemspec = eval(IO.read('mixlib-log.gemspec'))

Rake::GemPackageTask.new(gemspec).define

begin
  require 'rubygems'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
  end

rescue LoadError
  task :spec do
    abort "Rspec is not available. (sudo) gem install rspec to run unit tests"
  end
end

task :default => :spec


Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mixlib-log #{Mixlib::Log::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

