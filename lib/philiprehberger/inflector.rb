# frozen_string_literal: true

require_relative 'inflector/version'
require_relative 'inflector/rules'

module Philiprehberger
  module Inflector
    class Error < StandardError; end

    # Return the plural form of a word
    #
    # @param word [String] the word to pluralize
    # @return [String] the pluralized word
    def self.pluralize(word)
      return word if word.empty? || Rules::UNCOUNTABLES.include?(word.downcase)

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
      return word if word.empty? || Rules::UNCOUNTABLES.include?(word.downcase)

      Rules::SINGULARS.each do |pattern, replacement|
        return word.sub(pattern, replacement) if word.match?(pattern)
      end

      word
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
      key = underscore(class_name.to_s.gsub(/::/, '/').split('/').last)
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
      result.gsub!(/::/, '/')
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
  end
end
