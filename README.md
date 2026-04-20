# philiprehberger-inflector

[![Tests](https://github.com/philiprehberger/rb-inflector/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-inflector/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-inflector.svg)](https://rubygems.org/gems/philiprehberger-inflector)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/rb-inflector)](https://github.com/philiprehberger/rb-inflector/commits/main)

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

### Count with word agreement

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.count(1, 'apple')  # => "1 apple"
Philiprehberger::Inflector.count(0, 'apple')  # => "0 apples"
Philiprehberger::Inflector.count(3, 'goose')  # => "3 geese"
```

### Case Conversions

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.underscore('UserAccount')  # => "user_account"
Philiprehberger::Inflector.camelize('user_account')   # => "UserAccount"
Philiprehberger::Inflector.humanize('author_id')      # => "Author"
Philiprehberger::Inflector.titleize('user_account')   # => "User Account"
```

### Database Conventions

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.tableize('UserAccount')   # => "user_accounts"
Philiprehberger::Inflector.classify('user_accounts')  # => "UserAccount"
Philiprehberger::Inflector.foreign_key('User')        # => "user_id"
```

### URL Parameters

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.parameterize('Hello World!')  # => "hello-world"
```

### Ordinals

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.ordinalize(1)   # => "1st"
Philiprehberger::Inflector.ordinalize(2)   # => "2nd"
Philiprehberger::Inflector.ordinalize(3)   # => "3rd"
Philiprehberger::Inflector.ordinalize(11)  # => "11th"
Philiprehberger::Inflector.ordinalize(21)  # => "21st"
```

### Dasherize

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.dasherize('some_thing')  # => "some-thing"
```

### Demodulize

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.demodulize('Admin::User')  # => "User"
Philiprehberger::Inflector.demodulize('User')          # => "User"
```

### Deconstantize

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.deconstantize('Admin::User')       # => "Admin"
Philiprehberger::Inflector.deconstantize('Admin::Team::User') # => "Admin::Team"
Philiprehberger::Inflector.deconstantize('User')              # => ""
```

### Upcase First

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.upcase_first('hello world')  # => "Hello world"
Philiprehberger::Inflector.upcase_first('HELLO')        # => "HELLO"
```

### Custom Rules

```ruby
require "philiprehberger/inflector"

Philiprehberger::Inflector.add_irregular('person', 'people')
Philiprehberger::Inflector.add_plural_rule(/ox$/i, 'oxen')
Philiprehberger::Inflector.add_singular_rule(/oxen$/i, 'ox')
Philiprehberger::Inflector.add_uncountable('metadata', 'bandwidth')
```

### String Refinements

For a more natural syntax, use the refinements module:

```ruby
require "philiprehberger/inflector"
using Philiprehberger::Inflector::StringRefinements

'user_account'.camelize        # => "UserAccount"
'UserAccount'.tableize         # => "user_accounts"
'Hello World!'.parameterize    # => "hello-world"
'Admin::User'.demodulize       # => "User"
1.ordinalize                   # => "1st"
```

## API

| Method | Description |
|--------|-------------|
| `Inflector.pluralize(word)` | Return the plural form of a word |
| `Inflector.singularize(word)` | Return the singular form of a word |
| `Inflector.count(n, word)` | Format count with singular/plural agreement |
| `Inflector.tableize(class_name)` | Convert class name to table name |
| `Inflector.classify(table_name)` | Convert table name to class name |
| `Inflector.foreign_key(class_name, separate_id:)` | Generate foreign key from class name |
| `Inflector.parameterize(str, separator:)` | Convert to URL-friendly form |
| `Inflector.underscore(str)` | Convert CamelCase to snake_case |
| `Inflector.camelize(str, uppercase_first:)` | Convert snake_case to CamelCase |
| `Inflector.humanize(str)` | Convert to human-readable form |
| `Inflector.titleize(str)` | Convert to title case |
| `Inflector.ordinalize(number)` | Convert number to ordinal string |
| `Inflector.dasherize(str)` | Convert underscores to dashes |
| `Inflector.demodulize(str)` | Remove module namespace prefix |
| `Inflector.deconstantize(str)` | Remove rightmost constant segment |
| `Inflector.upcase_first(str)` | Uppercase only the first character |
| `Inflector.add_irregular(singular, plural)` | Register irregular singular/plural pair |
| `Inflector.add_plural_rule(pattern, replacement)` | Register custom plural rule |
| `Inflector.add_singular_rule(pattern, replacement)` | Register custom singular rule |
| `Inflector.add_uncountable(*words)` | Register uncountable words |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## Support

If you find this project useful:

⭐ [Star the repo](https://github.com/philiprehberger/rb-inflector)

🐛 [Report issues](https://github.com/philiprehberger/rb-inflector/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

💡 [Suggest features](https://github.com/philiprehberger/rb-inflector/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

❤️ [Sponsor development](https://github.com/sponsors/philiprehberger)

🌐 [All Open Source Projects](https://philiprehberger.com/open-source-packages)

💻 [GitHub Profile](https://github.com/philiprehberger)

🔗 [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
