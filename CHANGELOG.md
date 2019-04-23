# Change Log

<!-- latest_release 3.0.2 -->
## [v3.0.2](https://github.com/chef/mixlib-log/tree/v3.0.2) (2019-04-23)

#### Merged Pull Requests
- Expand testing / Update GitHub templates [#51](https://github.com/chef/mixlib-log/pull/51) ([tas50](https://github.com/tas50))
<!-- latest_release -->

<!-- release_rollup since=3.0.1 -->
### Changes not yet released to rubygems.org

#### Merged Pull Requests
- Expand testing / Update GitHub templates [#51](https://github.com/chef/mixlib-log/pull/51) ([tas50](https://github.com/tas50)) <!-- 3.0.2 -->
<!-- release_rollup -->

<!-- latest_stable_release -->
## [v3.0.1](https://github.com/chef/mixlib-log/tree/v3.0.1) (2019-01-05)

#### Merged Pull Requests
- reverting back to ruby 2.3 support [#48](https://github.com/chef/mixlib-log/pull/48) ([lamont-granquist](https://github.com/lamont-granquist))
<!-- latest_stable_release -->

## [v3.0.0](https://github.com/chef/mixlib-log/tree/v3.0.0) (2019-01-04)

#### Merged Pull Requests
- update travis, drop ruby &lt; 2.5, major version bump [#47](https://github.com/chef/mixlib-log/pull/47) ([lamont-granquist](https://github.com/lamont-granquist))

## [v2.0.9](https://github.com/chef/mixlib-log/tree/v2.0.9) (2018-12-18)

#### Merged Pull Requests
- remove hashrocket syntax [#41](https://github.com/chef/mixlib-log/pull/41) ([lamont-granquist](https://github.com/lamont-granquist))
- Remove the changelog generator gem [#42](https://github.com/chef/mixlib-log/pull/42) ([tas50](https://github.com/tas50))
- Test on all the Ruby versions we support [#43](https://github.com/chef/mixlib-log/pull/43) ([tas50](https://github.com/tas50))
- Test on Ruby 2.6 in Travis + test on Xenial [#46](https://github.com/chef/mixlib-log/pull/46) ([tas50](https://github.com/tas50))
- Only ship the required library files in the gem artifact [#45](https://github.com/chef/mixlib-log/pull/45) ([tas50](https://github.com/tas50))

## [v2.0.4](https://github.com/chef/mixlib-log/tree/v2.0.4) (2018-04-12)

#### Merged Pull Requests
- fix labelling [#37](https://github.com/chef/mixlib-log/pull/37) ([thommay](https://github.com/thommay))

## [2.0.1](https://github.com/chef/mixlib-log/tree/2.0.1) (2018-02-28)
[Full Changelog](https://github.com/chef/mixlib-log/compare/v2.0.0...2.0.1)

**Merged pull requests:**

- enable metadata to be got and set [\#32](https://github.com/chef/mixlib-log/pull/32) ([thommay](https://github.com/thommay))
- Logging methods \(debug, info, warn, error, fatal\) all return nil [\#27](https://github.com/chef/mixlib-log/pull/27) ([olleolleolle](https://github.com/olleolleolle))

## [v2.0.0](https://github.com/chef/mixlib-log/tree/v2.0.0) (2018-02-27)
[Full Changelog](https://github.com/chef/mixlib-log/compare/v1.7.1...v2.0.0)

**Merged pull requests:**

- Structured Logging [\#30](https://github.com/chef/mixlib-log/pull/30) ([thommay](https://github.com/thommay))
- RSpec: use 3.7, disable monkey patching mode [\#28](https://github.com/chef/mixlib-log/pull/28) ([olleolleolle](https://github.com/olleolleolle))
- README: Format a line of code using Markdown, not RDoc [\#24](https://github.com/chef/mixlib-log/pull/24) ([olleolleolle](https://github.com/olleolleolle))
- Travis: update Ruby versions, pass lint [\#22](https://github.com/chef/mixlib-log/pull/22) ([olleolleolle](https://github.com/olleolleolle))
- Require Ruby 2.2+ [\#20](https://github.com/chef/mixlib-log/pull/20) ([tas50](https://github.com/tas50))

## [v1.7.1](https://github.com/chef/mixlib-log/tree/v1.7.1) (2016-08-12)
[Full Changelog](https://github.com/chef/mixlib-log/compare/v1.7.0...v1.7.1)

**Merged pull requests:**

- Release 1.7.1 [\#19](https://github.com/chef/mixlib-log/pull/19) ([mwrock](https://github.com/mwrock))
- Allow applications to query if they've got loggers [\#18](https://github.com/chef/mixlib-log/pull/18) ([thommay](https://github.com/thommay))

## [v1.7.0](https://github.com/chef/mixlib-log/tree/v1.7.0) (2016-08-04)
[Full Changelog](https://github.com/chef/mixlib-log/compare/1.4.1...v1.7.0)

**Merged pull requests:**

- test with updated ruby versions and run cucumber [\#16](https://github.com/chef/mixlib-log/pull/16) ([thommay](https://github.com/thommay))
- Add dev dependency on chefstyle [\#15](https://github.com/chef/mixlib-log/pull/15) ([tas50](https://github.com/tas50))
- Misc cleanup + add Travis [\#14](https://github.com/chef/mixlib-log/pull/14) ([tas50](https://github.com/tas50))
- File log devices opened by mixlib-log should be closed. [\#13](https://github.com/chef/mixlib-log/pull/13) ([mhorbul](https://github.com/mhorbul))
- Include the license type in the .gemspec [\#9](https://github.com/chef/mixlib-log/pull/9) ([benders](https://github.com/benders))
- MIXLIB-10: don't be so pessimistic about development libraries [\#8](https://github.com/chef/mixlib-log/pull/8) ([jkeiser](https://github.com/jkeiser))
- Ensure that arguments to Mixlib::Log\#add are passed as is to all loggers [\#7](https://github.com/chef/mixlib-log/pull/7) ([ketan](https://github.com/ketan))
- Fixing RDoc formatting of README.rdoc. [\#4](https://github.com/chef/mixlib-log/pull/4) ([ampledata](https://github.com/ampledata))

## [1.4.1](https://github.com/chef/mixlib-log/tree/1.4.1) (2012-06-08)
[Full Changelog](https://github.com/chef/mixlib-log/compare/1.4.0...1.4.1)

## [1.4.0](https://github.com/chef/mixlib-log/tree/1.4.0) (2012-06-08)
[Full Changelog](https://github.com/chef/mixlib-log/compare/1.3.0...1.4.0)

**Merged pull requests:**

- Inconsistent documentation about default base log level [\#5](https://github.com/chef/mixlib-log/pull/5) ([bjoernalbers](https://github.com/bjoernalbers))

## [1.3.0](https://github.com/chef/mixlib-log/tree/1.3.0) (2011-03-17)
[Full Changelog](https://github.com/chef/mixlib-log/compare/1.2.0...1.3.0)

## [1.2.0](https://github.com/chef/mixlib-log/tree/1.2.0) (2010-10-15)
[Full Changelog](https://github.com/chef/mixlib-log/compare/alpha_deploy_2...1.2.0)

## [alpha_deploy_2](https://github.com/chef/mixlib-log/tree/alpha_deploy_2) (2010-02-28)
[Full Changelog](https://github.com/chef/mixlib-log/compare/alpha_deploy_3...alpha_deploy_2)

## [alpha_deploy_3](https://github.com/chef/mixlib-log/tree/alpha_deploy_3) (2010-02-28)
[Full Changelog](https://github.com/chef/mixlib-log/compare/alpha_deploy_4...alpha_deploy_3)

## [alpha_deploy_4](https://github.com/chef/mixlib-log/tree/alpha_deploy_4) (2010-02-28)
[Full Changelog](https://github.com/chef/mixlib-log/compare/beta-1...alpha_deploy_4)

## [beta-1](https://github.com/chef/mixlib-log/tree/beta-1) (2010-02-28)
[Full Changelog](https://github.com/chef/mixlib-log/compare/1.1.0...beta-1)

## [1.1.0](https://github.com/chef/mixlib-log/tree/1.1.0) (2010-02-28)
[Full Changelog](https://github.com/chef/mixlib-log/compare/v1.1.0...1.1.0)

## [v1.1.0](https://github.com/chef/mixlib-log/tree/v1.1.0) (2010-01-05)
[Full Changelog](https://github.com/chef/mixlib-log/compare/alpha_deploy_1...v1.1.0)

## [alpha_deploy_1](https://github.com/chef/mixlib-log/tree/alpha_deploy_1) (2009-05-12)
[Full Changelog](https://github.com/chef/mixlib-log/compare/v1.0.3...alpha_deploy_1)

## [v1.0.3](https://github.com/chef/mixlib-log/tree/v1.0.3) (2009-05-12)
[Full Changelog](https://github.com/chef/mixlib-log/compare/v1.0.2...v1.0.3)

## [v1.0.2](https://github.com/chef/mixlib-log/tree/v1.0.2) (2009-05-12)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*