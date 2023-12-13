# frozen_string_literal: true

require_relative 'lib/tag_auth/version'

Gem::Specification.new do |spec|
  spec.name     = 'tag_auth'
  spec.version  = TagAuth::VERSION
  spec.authors  = ['Lucia Lopúchová']
  spec.email    = ['lucia.lopuchova@muziker.com']

  spec.summary               = 'TagAuth provides tag authentication method'
  spec.description           = 'TagAuth integrates tag-based authentication into Rails applications using Devise.'
  spec.homepage              = 'https://github.com/lucialopuchova/tag_auth'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/main/CHANGELOG.md"
  }

  spec.files = Dir['{lib}/**/*', 'CHANGELOG.md', 'README.md']
  spec.test_files = Dir['spec/**/*', 'gemfiles/*.gemfile', 'gemfiles/*.gemfile.lock']

  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 4.2.0'
  spec.add_dependency 'devise', '>= 3.2'
  spec.add_dependency 'rake', '~> 13.0'
  spec.add_dependency 'rubocop', '~> 1.21'
  spec.add_dependency 'simple_token_authentication', '~> 1.0'

  spec.add_development_dependency 'generator_spec', '>= 0.1.0'
  spec.add_development_dependency 'rspec', '~> 3.12'
end
