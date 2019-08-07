# Mixlib::Log

[![Gem Version](https://badge.fury.io/rb/mixlib-log.svg)](https://badge.fury.io/rb/mixlib-log)
[![Build status](https://badge.buildkite.com/cb1e5b6f3cc77071f4b2315f6b605fe60d86e2862a490873d4.svg?branch=master)](https://buildkite.com/chef-oss/chef-mixlib-log-master-verify)

**Umbrella Project**: [Chef Foundation](https://github.com/chef/chef-oss-practices/blob/master/projects/chef-foundation.md)

**Project State**: [Active](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md#active)

**Issues [Response Time Maximum](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md)**: 14 days

**Pull Request [Response Time Maximum](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md)**: 14 days

Mixlib::Log provides a mixin for enabling a class based logger object, a-la Merb, Chef, and Nanite. To use it:

```ruby
require 'mixlib/log'

class Log
  extend Mixlib::Log
end
```

You can then do:

```ruby
Log.debug('foo')
Log.info('bar')
Log.warn('baz')
Log.error('baz')
Log.fatal('wewt')
```

By default, `Mixlib::Logger` logs to STDOUT. To alter this, you should call `Log.init`, passing any arguments to the standard Ruby Logger. For example:

```ruby
Log.init('/tmp/logfile')  # log to /tmp/logfile
Log.init('/tmp/logfile', 7)  # log to /tmp/logfile, rotate every day
```

Enjoy!

## Documentation

All documentation is written using YARD. You can generate a by running:

```
rake docs
```

## Contributing

For information on contributing to this project please see our [Contributing Documentation](https://github.com/chef/chef/blob/master/CONTRIBUTING.md)

## License & Copyright

- Copyright:: Copyright (c) 2008-2019 Chef Software, Inc.
- License:: Apache License, Version 2.0

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
