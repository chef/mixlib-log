
source "https://rubygems.org"

gemspec

group :test do
  gem "activesupport", "< 6" # this dep can be removed when we drop Ruby 2.4 support
  gem "chefstyle"
  gem "cucumber", "< 5" # remove the version pin when we drop Ruby 2.4 support
  gem "rake"
  gem "rspec", "~> 3.7"
  gem "rubocop-ast", "= 1.4.1" # Drop this dependency/version when we remove ruby-2.4 support
end

group :debug do
  gem "pry"
  gem "pry-byebug"
  gem "rb-readline"
end
