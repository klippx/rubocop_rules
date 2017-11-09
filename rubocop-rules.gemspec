
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop_rules/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop_rules'
  spec.version       = RubocopRules::VERSION
  spec.authors       = ['Mathias Klippinge']
  spec.email         = ['mathias.klippinge@gmail.com']

  spec.summary       = 'Common place to house rubocop enforcement across projects'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/rubocop-rules}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'rubocop', '~> 0.51.0'
  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
