# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/redirect/version'

Gem::Specification.new do |spec|
  spec.name          = "rack_redirect"
  spec.version       = Rack::Redirect::VERSION
  spec.authors       = ["Koen Punt"]
  spec.email         = ["koen@koenpunt.nl"]

  spec.summary       = %q{Generic Rack redirect middleware.}
  spec.description   = %q{Rack middleware to redirect requests based on path, but can be easily extended to match hostname, user-agent, or whatever might be available in the request.}
  spec.homepage      = "https://github.com/koenpunt/rack-redirect"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "rack", "~> 1.4"
end
