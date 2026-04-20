# frozen_string_literal: true

require_relative 'inflector/version'
require_relative 'inflector/rules'
require_relative 'inflector/string_refinements'

module Philiprehberger
  module Inflector
    class Error < StandardError; end

    @custom_plurals = []
    @custom_singulars = []
    @custom_uncountables = []

    class << self
      attr_reader :custom_plurals, :custom_singulars, :custom_uncountables
    end

    # Return the plural form of a word
    #
    # @param word [String] the word to pluralize
    # @return [String] the pluralized word
    def self.pluralize(word)
      return word if word.empty?
      return word if @custom_uncountables.include?(word.downcase) || Rules::UNCOUNTABLES.include?(word.downcase)

      @custom_plurals.each do |pattern, replacement|
        return word.sub(pattern, replacement) if word.match?(pattern)
      end

      Rules::PLURALS.each do |pattern, replacement|
        return word.sub(pattern, replacement) if word.match?(pattern)
      end

      word
    end

    # Return the singular form of a word
    #
    # @param word [String] the word to singularize
    # @return [String] the singularized word
    def self.singularize(word)
      return word if word.empty?
      return word if @custom_uncountables.include?(word.downcase) || Rules::UNCOUNTABLES.include?(word.downcase)

      @custom_singulars.each do |pattern, replacement|
        return word.sub(pattern, replacement) if word.match?(pattern)
      end

      Rules::SINGULARS.each do |pattern, replacement|
        return word.sub(pattern, replacement) if word.match?(pattern)
      end

      word
    end

    # Format a count with singular/plural word agreement
    #
    # Uses the existing +singularize+/+pluralize+ logic to choose the correct form based on +n+.
    # When +n.abs+ equals exactly 1, the singular form of +word+ is used; otherwise the plural form.
    # The original +n+ (Integer or Float) is preserved in the returned string.
    #
    # @param n [Integer, Float] the count value
    # @param word [String] the word to inflect
    # @return [String] the formatted string, e.g. "1 apple" or "5 geese"
    # @example
    #   Philiprehberger::Inflector.count(1, 'apple')   # => "1 apple"
    #   Philiprehberger::Inflector.count(0, 'apple')   # => "0 apples"
    #   Philiprehberger::Inflector.count(5, 'goose')   # => "5 geese"
    #   Philiprehberger::Inflector.count(-1, 'mouse')  # => "-1 mouse"
    #   Philiprehberger::Inflector.count(1.5, 'apple') # => "1.5 apples"
    def self.count(n, word)
      form = n.abs == 1 ? singularize(word) : pluralize(word)
      "#{n} #{form}"
    end

    # Convert a class name to a table name
    #
    # @param class_name [String] the class name (e.g. "UserAccount")
    # @return [String] the table name (e.g. "user_accounts")
    def self.tableize(class_name)
      pluralize(underscore(class_name))
    end

    # Convert a table name to a class name
    #
    # @param table_name [String] the table name (e.g. "user_accounts")
    # @return [String] the class name (e.g. "UserAccount")
    def self.classify(table_name)
      camelize(singularize(table_name.to_s.sub(/.*\./, '')))
    end

    # Create a foreign key name from a class name
    #
    # @param class_name [String] the class name (e.g. "User")
    # @param separate_id [Boolean] whether to separate with underscore
    # @return [String] the foreign key (e.g. "user_id")
    def self.foreign_key(class_name, separate_id: true)
      key = underscore(class_name.to_s.gsub('::', '/').split('/').last)
      "#{key}#{separate_id ? '_id' : 'id'}"
    end

    # Convert a string to a URL-friendly parameterized form
    #
    # @param str [String] the string to parameterize
    # @param separator [String] the separator character
    # @return [String] the parameterized string
    def self.parameterize(str, separator: '-')
      result = str.to_s.dup
      result.gsub!(/[^a-zA-Z0-9\-_]+/, separator)
      result.gsub!(/#{Regexp.escape(separator)}{2,}/, separator) unless separator.empty?
      result.gsub!(/^#{Regexp.escape(separator)}|#{Regexp.escape(separator)}$/, '') unless separator.empty?
      result.downcase
    end

    # Convert a CamelCase string to snake_case
    #
    # @param str [String] the CamelCase string
    # @return [String] the snake_case string
    def self.underscore(str)
      result = str.to_s.dup
      result.gsub!('::', '/')
      result.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      result.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      result.tr!('-', '_')
      result.downcase!
      result
    end

    # Convert a snake_case or dashed string to CamelCase
    #
    # @param str [String] the string to camelize
    # @param uppercase_first [Boolean] whether to uppercase the first letter
    # @return [String] the CamelCase string
    def self.camelize(str, uppercase_first: true)
      result = str.to_s.dup
      result = if uppercase_first
                 result.sub(/^[a-z\d]*/, &:capitalize)
               else
                 result.sub(/^(?:(?=\b|[A-Z_])|\w)/, &:downcase)
               end
      result.gsub!(%r{(?:_|(/))([a-z\d]*)}) { "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}" }
      result.gsub!('/', '::')
      result
    end

    # Convert an underscored or CamelCase string to a human-readable form
    #
    # @param str [String] the string to humanize
    # @return [String] the humanized string
    def self.humanize(str)
      result = str.to_s.dup
      result.sub!(/_id$/, '')
      result.tr!('_', ' ')
      result.gsub!(/([a-z\d])([A-Z])/, '\1 \2')
      result.gsub!(/\b([a-z])/) { Regexp.last_match(1).capitalize }
      result.strip
    end

    # Convert a string to title case
    #
    # @param str [String] the string to titleize
    # @return [String] the titleized string
    def self.titleize(str)
      humanize(underscore(str))
    end

    # Convert a number to its ordinal string
    #
    # @param number [Integer] the number to ordinalize
    # @return [String] the ordinal string (e.g. "1st", "2nd", "3rd")
    def self.ordinalize(number)
      abs_number = number.to_i.abs
      suffix = if (11..13).cover?(abs_number % 100)
                 'th'
               else
                 case abs_number % 10
                 when 1 then 'st'
                 when 2 then 'nd'
                 when 3 then 'rd'
                 else 'th'
                 end
               end
      "#{number}#{suffix}"
    end

    # Convert underscores to dashes in a string
    #
    # @param str [String] the underscored string
    # @return [String] the dashed string
    def self.dasherize(str)
      str.to_s.tr('_', '-')
    end

    # Remove the module namespace from a fully qualified class name
    #
    # @param str [String] the fully qualified class name (e.g. "Admin::User")
    # @return [String] the class name without namespace (e.g. "User")
    def self.demodulize(str)
      path = str.to_s
      if (index = path.rindex('::'))
        path[(index + 2)..]
      else
        path
      end
    end

    # Register a custom pluralization rule
    #
    # @param pattern [Regexp, String] the pattern to match
    # @param replacement [String] the replacement string
    def self.add_plural_rule(pattern, replacement)
      pattern = /#{pattern}/i if pattern.is_a?(String)
      @custom_plurals.unshift([pattern, replacement])
    end

    # Register a custom singularization rule
    #
    # @param pattern [Regexp, String] the pattern to match
    # @param replacement [String] the replacement string
    def self.add_singular_rule(pattern, replacement)
      pattern = /#{pattern}/i if pattern.is_a?(String)
      @custom_singulars.unshift([pattern, replacement])
    end

    # Remove the rightmost segment from a fully qualified constant name
    #
    # @param str [String] the fully qualified constant name (e.g. "Admin::User")
    # @return [String] the constant without the rightmost segment (e.g. "Admin")
    def self.deconstantize(str)
      path = str.to_s
      if (index = path.rindex('::'))
        path[0, index]
      else
        ''
      end
    end

    # Uppercase only the first character of a string
    #
    # @param str [String] the string to modify
    # @return [String] the string with the first character uppercased
    def self.upcase_first(str)
      str = str.to_s
      return str if str.empty?

      str[0].upcase + str[1..]
    end

    # Register an irregular singular/plural pair
    #
    # @param singular [String] the singular form (e.g. "person")
    # @param plural [String] the plural form (e.g. "people")
    def self.add_irregular(singular, plural)
      s0 = singular[0]
      srest = singular[1..]
      p0 = plural[0]
      prest = plural[1..]

      add_plural_rule(/(#{s0})#{srest}$/i, "\\1#{prest}")
      add_singular_rule(/(#{p0})#{prest}$/i, "\\1#{srest}")
    end

    # Register additional uncountable words
    #
    # @param words [Array<String>] the words to add
    def self.add_uncountable(*words)
      @custom_uncountables.push(*words.flatten.map(&:downcase))
    end
  end
end
