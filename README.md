# Rack::Redirect

Rack::Redirect, generic Rack redirect middleware.

By default to redirect requests based on path, but can be easily extended to match hostname, user-agent, or whatever might be available in the request.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack_redirect'
```

And then execute:

    $ bundle

## Usage

### Rackup

Add to `config.ru`:

```rb
require 'rack/redirect'
use Rack::Redirect, {
  '/some/path'    => '/new/path',
  %r{^/profiles}' => '/users'
}

use Rack::Redirect, {
  '/home' => '/'
}, 301
```

### Rails

Add to `config/application.rb` (or any of the environment files):

```rb
config.middleware.insert_before 0, Rack::Redirect, {
  '/some/path'    => '/new/path',
  %r{^/profiles}' => '/users'
}

config.middleware.insert_before 0, Rack::Redirect, {
  '/home' => '/'
}, 301

```

## Extending

To extend the functionality for e.g. user-agent detection, it's as simple as:

```rb
class UserAgentRedirect < Rack::Redirect
  def request_matches?(request, pattern)
    request.user_agent =~ pattern
  end
end

use UserAgentRedirect, {
  /iP(hone|od)/ => '/mobile'
}
```

The pattern can actually be anything, so if you wan't use more variables in a single check, that's also possible:

```rb
class UserAgentAndPathRedirect < Rack::Redirect
  def request_matches?(request, pattern)
    request.user_agent =~ pattern[0] && request.path == pattern[1]
  end
end

use UserAgentAndPathRedirect, {
  [/iP(hone|od)/, '/mobile'] => '/iphone'
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/koenpunt/rack-redirect.
