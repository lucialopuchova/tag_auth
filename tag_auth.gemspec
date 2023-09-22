# frozen_string_literal: true

require_relative "lib/tag_auth/version"

Gem::Specification.new do |spec|
  spec.name     = "tag_auth"
  spec.version  = TagAuth::VERSION
  spec.authors  = ["Lucia Lopúchová"]
  spec.email    = ["lucia.lopuchova@muziker.com"]

  spec.summary               = "TagAuth provides tag authentication method"
  spec.description           = "TagAuth provides tag authentication method"
  spec.homepage              = "https://github.com/lucialopuchova/tag_auth"
  spec.license               = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata = {
    "homepage_uri"    => spec.homepage,
    "source_code_uri" => spec.homepage,
    "changelog_uri"   => "#{spec.homepage}/blob/main/CHANGELOG.md"
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["{lib}/**/*", "CHANGELOG.md", "README.md"]

  spec.require_paths = ["lib"]

end
