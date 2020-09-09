
source "https://rubygems.org"

gemspec

group :docs do
  gem "github-markup"
  gem "redcarpet"
  gem "yard"
end

group :test do
  gem "activesupport", "< 6" # this dep can be removed when we drop Ruby 2.4 support
  gem "chefstyle"
  gem "cucumber", "< 5" # remove the version pin when we drop Ruby 2.4 support
  gem "rake"
  gem "rspec", "~> 3.7"
end

group :debug do
  gem "pry"
  gem "pry-byebug"
  gem "pry-stack_explorer", "~> 0.4.0" # pin until we drop ruby < 2.6
  gem "rb-readline"
end
