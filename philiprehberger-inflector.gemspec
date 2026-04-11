# frozen_string_literal: true

require_relative 'lib/philiprehberger/inflector/version'

Gem::Specification.new do |spec|
  spec.name = 'philiprehberger-inflector'
  spec.version = Philiprehberger::Inflector::VERSION
  spec.authors = ['Philip Rehberger']
  spec.email = ['me@philiprehberger.com']

  spec.summary = 'Rails-compatible string inflections without ActiveSupport dependency'
  spec.description = 'Provides pluralize, singularize, camelize, underscore, tableize, classify, ordinalize, ' \
                     'dasherize, demodulize, deconstantize, and other string inflection methods compatible ' \
                     'with Rails conventions, with zero dependencies.'
  spec.homepage = 'https://philiprehberger.com/open-source-packages/ruby/philiprehberger-inflector'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/philiprehberger/rb-inflector'
  spec.metadata['changelog_uri'] = 'https://github.com/philiprehberger/rb-inflector/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/philiprehberger/rb-inflector/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
