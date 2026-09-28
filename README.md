# Mixlib::Log

[![Gem Version](https://badge.fury.io/rb/mixlib-log.svg)](https://badge.fury.io/rb/mixlib-log)
[![Unit Tests](https://github.com/chef/mixlib-log/actions/workflows/unit.yml/badge.svg?branch=main)](https://github.com/chef/mixlib-log/actions/workflows/unit.yml)
[![Lint](https://github.com/chef/mixlib-log/actions/workflows/lint.yml/badge.svg?branch=main)](https://github.com/chef/mixlib-log/actions/workflows/lint.yml)

Mixlib::Log provides a mixin for enabling a class based logger object, a-la
Merb, Chef, and Nanite. To use it:

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

By default, `Mixlib::Log` logs to STDOUT at the `:warn` level. To log somewhere else, call `Log.init` with a file path, an IO object, or an existing logger object. For example:

```ruby
Log.init('/tmp/logfile')          # log to /tmp/logfile
Log.init($stderr)                 # log to an IO
Log.init(Logger.new('/tmp/log'))  # use a logger you've already configured
Log.level = :info
```

Log files are never rotated. If you need rotation, pass in a `::Logger` configured for it, or use an external tool such as logrotate.

Enjoy!

## Documentation

All documentation is written using YARD. You can generate a by running:

```
rake docs
```

## Contributing

For information on contributing to this project please see our [Contributing Documentation](https://github.com/chef/chef/blob/main/CONTRIBUTING.md)

## License 

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
# Copyright

See [COPYRIGHT.md](./COPYRIGHT.md).
