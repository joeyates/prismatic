# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prismatic/version'

Gem::Specification.new do |spec|
  spec.name          = 'prismatic'
  spec.version       = Prismatic::VERSION
  spec.authors       = ['Joe Yates']
  spec.email         = ['joe.g.yates@gmail.com']
  spec.summary       = "Automate SitePrism's access to DOM elements"
  spec.description   = <<-EOT.gsub(/^ +/, '').gsub(/\n/, ' ')
    Thanks to a naming convention, Prismatic recognises the DOM elements in your
    web pages that you intend to access during integration tests and automatically
    creates the intended SitePrism sections and elements.
  EOT
  spec.homepage      = 'https://github.com/joeyates/prismatic'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'site_prism', '~> 2.6'
  spec.add_dependency 'docile', '~> 1.1'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
