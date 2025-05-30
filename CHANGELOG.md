# Change Log

<!-- latest_release 3.2.5 -->
## [v3.2.5](https://github.com/chef/mixlib-log/tree/v3.2.5) (2025-05-12)

#### Merged Pull Requests
- add myself to codeowners [#85](https://github.com/chef/mixlib-log/pull/85) ([jaymzh](https://github.com/jaymzh))
<!-- latest_release -->

<!-- release_rollup since=3.1.2 -->
### Changes not yet released to rubygems.org

#### Merged Pull Requests
- add myself to codeowners [#85](https://github.com/chef/mixlib-log/pull/85) ([jaymzh](https://github.com/jaymzh)) <!-- 3.2.5 -->
- ruby 3.4 upgrade [#86](https://github.com/chef/mixlib-log/pull/86) ([rishichawda](https://github.com/rishichawda)) <!-- 3.2.4 -->
<!-- release_rollup -->

<!-- latest_stable_release -->
## [v3.1.2](https://github.com/chef/mixlib-log/tree/v3.1.2) (2025-04-10)
<!-- latest_stable_release -->

## [v3.1.2](https://github.com/chef/mixlib-log/tree/v3.1.2) (2025-04-10)

## [v3.2.3](https://github.com/chef/mixlib-log/tree/v3.2.3) (2025-04-01)

#### Merged Pull Requests
- Chefstyle to Cookstyle migration [#79](https://github.com/chef/mixlib-log/pull/79) ([dafyddcrosby](https://github.com/dafyddcrosby))
- updating ffi for Ohai [#83](https://github.com/chef/mixlib-log/pull/83) ([johnmccrae](https://github.com/johnmccrae))
- Relax ffi dependency to allow 1.17.1 and up [#82](https://github.com/chef/mixlib-log/pull/82) ([stanhu](https://github.com/stanhu))

## [v3.2.0](https://github.com/chef/mixlib-log/tree/v3.2.0) (2025-01-28)

#### Merged Pull Requests
- Fix formatter regression from Ruby 3.3 Logger fix [#78](https://github.com/chef/mixlib-log/pull/78) ([stanhu](https://github.com/stanhu))
- Move ffi dependency forward [#81](https://github.com/chef/mixlib-log/pull/81) ([jaymzh](https://github.com/jaymzh))

## [v3.1.1](https://github.com/chef/mixlib-log/tree/v3.1.1) (2024-07-12)

#### Merged Pull Requests
- Replace __FILE__ with __dir__ and other minor chefstyle fixes [#61](https://github.com/chef/mixlib-log/pull/61) ([tas50](https://github.com/tas50))
- Add Ruby 3.0 testing [#62](https://github.com/chef/mixlib-log/pull/62) ([tas50](https://github.com/tas50))
- Upgrade to GitHub-native Dependabot [#63](https://github.com/chef/mixlib-log/pull/63) ([dependabot-preview[bot]](https://github.com/dependabot-preview[bot]))
- Remove  Ruby 2.4 support  and Test Ruby 3.0/3.1 [#66](https://github.com/chef/mixlib-log/pull/66) ([poorndm](https://github.com/poorndm))
- Bump minimum to 2.7 [#75](https://github.com/chef/mixlib-log/pull/75) ([tpowell-progress](https://github.com/tpowell-progress))
- Support ruby3.3 Logger by properly initialize super class [#74](https://github.com/chef/mixlib-log/pull/74) ([mtasaka](https://github.com/mtasaka))
- ffi less than 1.17.0 because of ruby 3.0 [#77](https://github.com/chef/mixlib-log/pull/77) ([tpowell-progress](https://github.com/tpowell-progress))

## [v3.0.9](https://github.com/chef/mixlib-log/tree/v3.0.9) (2020-08-21)

#### Merged Pull Requests
- Optimize our requires [#60](https://github.com/chef/mixlib-log/pull/60) ([tas50](https://github.com/tas50))

## [v3.0.8](https://github.com/chef/mixlib-log/tree/v3.0.8) (2019-12-30)

#### Merged Pull Requests
- Expand testing / Update GitHub templates [#51](https://github.com/chef/mixlib-log/pull/51) ([tas50](https://github.com/tas50))
- Add Build Kite PR Testing [#52](https://github.com/chef/mixlib-log/pull/52) ([tas50](https://github.com/tas50))
- Remove Travis PR Testing [#53](https://github.com/chef/mixlib-log/pull/53) ([tas50](https://github.com/tas50))
- Resolve all warnings emitted during testing [#54](https://github.com/chef/mixlib-log/pull/54) ([zenspider](https://github.com/zenspider))
- Add windows testing in Buildkite [#56](https://github.com/chef/mixlib-log/pull/56) ([tas50](https://github.com/tas50))
- Test on Ruby 2.7 + random testing improvements [#58](https://github.com/chef/mixlib-log/pull/58) ([tas50](https://github.com/tas50))
- Substitute require for require_relative [#59](https://github.com/chef/mixlib-log/pull/59) ([tas50](https://github.com/tas50))

## [v3.0.1](https://github.com/chef/mixlib-log/tree/v3.0.1) (2019-01-05)

#### Merged Pull Requests
- reverting back to ruby 2.3 support [#48](https://github.com/chef/mixlib-log/pull/48) ([lamont-granquist](https://github.com/lamont-granquist))

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