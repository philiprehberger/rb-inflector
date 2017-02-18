# philiprehberger-inflector

[![Tests](https://github.com/philiprehberger/rb-inflector/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-inflector/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-inflector.svg)](https://rubygems.org/gems/philiprehberger-inflector)
[![License](https://img.shields.io/github/license/philiprehberger/rb-inflector)](LICENSE)

Rails-compatible string inflections without ActiveSupport dependency

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem "philiprehberger-inflector"
```

Or install directly:

```bash
gem install philiprehberger-inflector
```

## Usage

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.pluralize('cat')     # => "cats"
Philiprehberger::Inflector.singularize('cats')  # => "cat"
```

### Case Conversions

```ruby
Philiprehberger::Inflector.underscore('UserAccount')  # => "user_account"
Philiprehberger::Inflector.camelize('user_account')   # => "UserAccount"
Philiprehberger::Inflector.humanize('author_id')      # => "Author"
Philiprehberger::Inflector.titleize('user_account')   # => "User Account"
```

### Database Conventions

```ruby
Philiprehberger::Inflector.tableize('UserAccount')  # => "user_accounts"
Philiprehberger::Inflector.classify('user_accounts') # => "UserAccount"
Philiprehberger::Inflector.foreign_key('User')       # => "user_id"
```

### URL Parameters

```ruby
Philiprehberger::Inflector.parameterize('Hello World!')  # => "hello-world"
```

## API

| Method | Description |
|--------|-------------|
| `Inflector.pluralize(word)` | Return the plural form of a word |
| `Inflector.singularize(word)` | Return the singular form of a word |
| `Inflector.tableize(class_name)` | Convert class name to table name |
| `Inflector.classify(table_name)` | Convert table name to class name |
| `Inflector.foreign_key(class_name, separate_id:)` | Generate foreign key from class name |
| `Inflector.parameterize(str, separator:)` | Convert to URL-friendly form |
| `Inflector.underscore(str)` | Convert CamelCase to snake_case |
| `Inflector.camelize(str, uppercase_first:)` | Convert snake_case to CamelCase |
| `Inflector.humanize(str)` | Convert to human-readable form |
| `Inflector.titleize(str)` | Convert to title case |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
