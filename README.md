# Hiera-undef Puppet Module

[![Build Status](https://travis-ci.org/camptocamp/puppet-hiera-undef.png?branch=master)](https://travis-ci.org/camptocamp/puppet-hiera-undef)

This module is provided by [Camptocamp](http://www.camptocamp.com/)

## Why this module?

The `hiera` functions for Puppet are currently limited by the fact that Puppet
functions cannot receive the `undef` value as it gets munged before the function
receives it (see [ticket #20923](https://projects.puppetlabs.com/issues/20923)).

This module provides replacement functions that do not accept a `default` parameter,
but use `undef` instead.

This module was written to ease the migration from Puppet 2.7 to 3.0, by writing
wrapping classes using the `hiera_undef()` function. For example:

    class wrapping::myapp {
      class { 'myapp':
        param1 => hiera_undef('myapp::param1'),
        param2 => hiera_undef('myapp::param2'),
      }
    }

This approach allows to emulate data binding in Puppet 2.7 since:

* the name of the variable passed to `hiera_undef` is of the form `$class::$param`,
compatible with the way data bindings work;
* if the variable is not found in Hiera, the function returns `undef`, and the
class default is used, just like data bindings would do it.

The advantages of this approach are that:

* only one level of wrapping classes is necessary (no turtles all the way down
with global parameters);
* it is compatible with both Puppet 2.X and 3.X;
* the wrapping classes can safely be removed in Puppet 3.X as data binding
will replace the calls to `hiera_undef()`.


## Example

A simple example might explain better than words. In the following examples,
the `foobar` variable is not found in any Hiera backends in the current scope:

    notify { 'test':
      message => hiera('foobar', undef),
    }

returns:

    Notice: 
    Notice: /Stage[main]//Notify[test]/message: defined 'message' as ''

whereas:

    notify { 'test':
      message => hiera_undef('foobar'),
    }

returns:

    Notice: test
    Notice: /Stage[main]//Notify[test]/message: defined 'message' as 'test'

 
## Contributing

Please report bugs and feature request using [GitHub issue
tracker](https://github.com/camptocamp/puppet-hiera-undef/issues).

For pull requests, it is very much appreciated to check your Puppet manifest
with [puppet-lint](http://puppet-lint.com/) to follow the recommended Puppet style guidelines from the
[Puppet Labs style guide](http://docs.puppetlabs.com/guides/style_guide.html).
 
## License

Copyright (c) 2013 <mailto:puppet@camptocamp.com> All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
