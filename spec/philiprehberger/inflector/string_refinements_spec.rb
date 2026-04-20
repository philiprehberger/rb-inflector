# frozen_string_literal: true

require 'spec_helper'

# Refinements must be activated at the top level of the file or module where they are used
using Philiprehberger::Inflector::StringRefinements

RSpec.describe Philiprehberger::Inflector::StringRefinements do
  describe 'String refinements' do
    describe '#pluralize' do
      it 'pluralizes a word' do
        expect('cat'.pluralize).to eq('cats')
      end
    end

    describe '#singularize' do
      it 'singularizes a word' do
        expect('cats'.singularize).to eq('cat')
      end
    end

    describe '#count' do
      it 'formats count with pluralized word' do
        expect('apple'.count(5)).to eq('5 apples')
      end

      it 'formats count with singular word when n is 1' do
        expect('apple'.count(1)).to eq('1 apple')
      end
    end

    describe '#tableize' do
      it 'converts class name to table name' do
        expect('UserAccount'.tableize).to eq('user_accounts')
      end
    end

    describe '#classify' do
      it 'converts table name to class name' do
        expect('user_accounts'.classify).to eq('UserAccount')
      end
    end

    describe '#foreign_key' do
      it 'generates foreign key from class name' do
        expect('User'.foreign_key).to eq('user_id')
      end

      it 'supports separate_id option' do
        expect('User'.foreign_key(separate_id: false)).to eq('userid')
      end
    end

    describe '#parameterize' do
      it 'converts to URL-friendly form' do
        expect('Hello World!'.parameterize).to eq('hello-world')
      end

      it 'supports custom separator' do
        expect('Hello World!'.parameterize(separator: '_')).to eq('hello_world')
      end
    end

    describe '#underscore' do
      it 'converts CamelCase to snake_case' do
        expect('UserAccount'.underscore).to eq('user_account')
      end
    end

    describe '#camelize' do
      it 'converts snake_case to CamelCase' do
        expect('user_account'.camelize).to eq('UserAccount')
      end

      it 'supports lowercase first letter' do
        expect('user_account'.camelize(uppercase_first: false)).to eq('userAccount')
      end
    end

    describe '#humanize' do
      it 'converts to human-readable form' do
        expect('author_id'.humanize).to eq('Author')
      end
    end

    describe '#titleize' do
      it 'converts to title case' do
        expect('user_account'.titleize).to eq('User Account')
      end
    end

    describe '#dasherize' do
      it 'converts underscores to dashes' do
        expect('some_thing'.dasherize).to eq('some-thing')
      end
    end

    describe '#demodulize' do
      it 'removes module namespace' do
        expect('Admin::User'.demodulize).to eq('User')
      end
    end

    describe '#deconstantize' do
      it 'removes rightmost constant segment' do
        expect('Admin::User'.deconstantize).to eq('Admin')
      end
    end

    describe '#upcase_first' do
      it 'uppercases only the first character' do
        expect('hello world'.upcase_first).to eq('Hello world')
      end
    end
  end

  describe 'Integer refinements' do
    describe '#ordinalize' do
      it 'converts number to ordinal string' do
        expect(1.ordinalize).to eq('1st')
      end

      it 'handles teens' do
        expect(11.ordinalize).to eq('11th')
      end

      it 'handles 2nd and 3rd' do
        expect(2.ordinalize).to eq('2nd')
        expect(3.ordinalize).to eq('3rd')
      end
    end
  end
end
