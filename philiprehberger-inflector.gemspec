# frozen_string_literal: true

require_relative 'lib/philiprehberger/inflector/version'

Gem::Specification.new do |spec|
  spec.name          = 'philiprehberger-inflector'
  spec.version       = Philiprehberger::Inflector::VERSION
  spec.authors       = ['Philip Rehberger']
  spec.email         = ['me@philiprehberger.com']

  spec.summary       = 'Rails-compatible string inflections without ActiveSupport dependency'
  spec.description   = 'Provides pluralize, singularize, camelize, underscore, tableize, classify, and other ' \
                       'string inflection methods compatible with Rails conventions, with zero dependencies.'
  spec.homepage      = 'https://github.com/philiprehberger/rb-inflector'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = spec.homepage
  spec.metadata['changelog_uri']         = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['bug_tracker_uri']       = "#{spec.homepage}/issues"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
