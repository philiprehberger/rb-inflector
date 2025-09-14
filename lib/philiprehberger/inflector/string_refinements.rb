# frozen_string_literal: true

module Philiprehberger
  module Inflector
    # Refinements module that adds inflection methods directly to String and Integer.
    #
    # Usage:
    #   using Philiprehberger::Inflector::StringRefinements
    #
    #   'user_account'.camelize   # => "UserAccount"
    #   1.ordinalize              # => "1st"
    module StringRefinements
      refine String do
        def pluralize
          Philiprehberger::Inflector.pluralize(self)
        end

        def singularize
          Philiprehberger::Inflector.singularize(self)
        end

        def tableize
          Philiprehberger::Inflector.tableize(self)
        end

        def classify
          Philiprehberger::Inflector.classify(self)
        end

        def foreign_key(separate_id: true)
          Philiprehberger::Inflector.foreign_key(self, separate_id: separate_id)
        end

        def parameterize(separator: '-')
          Philiprehberger::Inflector.parameterize(self, separator: separator)
        end

        def underscore
          Philiprehberger::Inflector.underscore(self)
        end

        def camelize(uppercase_first: true)
          Philiprehberger::Inflector.camelize(self, uppercase_first: uppercase_first)
        end

        def humanize
          Philiprehberger::Inflector.humanize(self)
        end

        def titleize
          Philiprehberger::Inflector.titleize(self)
        end

        def dasherize
          Philiprehberger::Inflector.dasherize(self)
        end

        def demodulize
          Philiprehberger::Inflector.demodulize(self)
        end

        def deconstantize
          Philiprehberger::Inflector.deconstantize(self)
        end

        def upcase_first
          Philiprehberger::Inflector.upcase_first(self)
        end
      end

      refine Integer do
        def ordinalize
          Philiprehberger::Inflector.ordinalize(self)
        end
      end
    end
  end
end
