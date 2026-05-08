# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.6.0] - 2026-05-08

### Added
- `Philiprehberger::Inflector.humanize_list(items, conjunction: 'and', oxford: true)` — formats an array as a human-readable list (e.g. `%w[a b c]` → `"a, b, and c"`); supports custom conjunction and an `oxford:` toggle for the serial comma

## [0.5.0] - 2026-04-22

### Added
- `Philiprehberger::Inflector.count(n, word)` — returns "n word" or "n words" based on count (uses existing singularize/pluralize). Also available as `String#count(n)` via the string refinement.

## [0.4.0] - 2026-04-12

### Added
- String refinements module for natural `'string'.method` syntax via `using Philiprehberger::Inflector::StringRefinements`
- Integer refinement for `1.ordinalize` via the same module
- All 14 string inflection methods available as refinements: `pluralize`, `singularize`, `tableize`, `classify`, `foreign_key`, `parameterize`, `underscore`, `camelize`, `humanize`, `titleize`, `dasherize`, `demodulize`, `deconstantize`, `upcase_first`

### Changed
- Reduce max line length from 140 to 120 for rubocop compliance

## [0.3.0] - 2026-04-10

### Added
- `deconstantize` for removing the rightmost segment from a constant name
- `upcase_first` for uppercasing only the first character of a string
- `add_irregular` for registering irregular singular/plural pairs (e.g., person/people)

## [0.2.0] - 2026-04-03

### Added
- `ordinalize` for converting numbers to ordinal strings (1st, 2nd, 3rd)
- `dasherize` for converting underscored strings to dashed form
- `demodulize` for removing module namespace prefixes
- Custom inflection rules via `add_plural_rule`, `add_singular_rule`, `add_uncountable`

## [0.1.5] - 2026-03-31

### Added
- Add GitHub issue templates, dependabot config, and PR template

## [0.1.4] - 2026-03-31

### Changed
- Standardize README badges, support section, and license format

## [0.1.3] - 2026-03-26

### Fixed
- Add Sponsor badge to README
- Fix license section link format

## [0.1.2] - 2026-03-24

### Fixed
- Remove inline comments from Development section to match template

## [0.1.1] - 2026-03-22

### Changed
- Version bump for republishing

## [0.1.0] - 2026-03-22

### Added
- Initial release
- Pluralize and singularize with common English rules
- Underscore, camelize, and humanize string conversions
- Tableize, classify, and foreign_key for database conventions
- Parameterize for URL-friendly strings
- Titleize for human-readable titles
- Uncountable word support
