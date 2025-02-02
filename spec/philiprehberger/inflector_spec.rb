# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Philiprehberger::Inflector do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

  describe '.pluralize' do
    it 'pluralizes regular words' do
      expect(described_class.pluralize('cat')).to eq('cats')
    end

    it 'pluralizes words ending in s' do
      expect(described_class.pluralize('bus')).to eq('buses')
    end

    it 'pluralizes words ending in x' do
      expect(described_class.pluralize('box')).to eq('boxes')
    end

    it 'pluralizes words ending in ch' do
      expect(described_class.pluralize('match')).to eq('matches')
    end

    it 'pluralizes words ending in consonant+y' do
      expect(described_class.pluralize('city')).to eq('cities')
    end

    it 'handles uncountable words' do
      expect(described_class.pluralize('sheep')).to eq('sheep')
    end

    it 'handles empty string' do
      expect(described_class.pluralize('')).to eq('')
    end
  end

  describe '.singularize' do
    it 'singularizes regular words' do
      expect(described_class.singularize('cats')).to eq('cat')
    end

    it 'singularizes words ending in es' do
      expect(described_class.singularize('boxes')).to eq('box')
    end

    it 'singularizes words ending in ies' do
      expect(described_class.singularize('cities')).to eq('city')
    end

    it 'handles uncountable words' do
      expect(described_class.singularize('sheep')).to eq('sheep')
    end

    it 'handles empty string' do
      expect(described_class.singularize('')).to eq('')
    end
  end

  describe '.tableize' do
    it 'converts class name to table name' do
      expect(described_class.tableize('UserAccount')).to eq('user_accounts')
    end

    it 'converts simple class name' do
      expect(described_class.tableize('User')).to eq('users')
    end
  end

  describe '.classify' do
    it 'converts table name to class name' do
      expect(described_class.classify('user_accounts')).to eq('UserAccount')
    end

    it 'converts simple table name' do
      expect(described_class.classify('users')).to eq('User')
    end

    it 'handles dotted table names' do
      expect(described_class.classify('schema.user_accounts')).to eq('UserAccount')
    end
  end

  describe '.foreign_key' do
    it 'generates foreign key from class name' do
      expect(described_class.foreign_key('User')).to eq('user_id')
    end

    it 'generates foreign key from multi-word class name' do
      expect(described_class.foreign_key('UserAccount')).to eq('user_account_id')
    end

    it 'generates foreign key without separator' do
      expect(described_class.foreign_key('User', separate_id: false)).to eq('userid')
    end
  end

  describe '.parameterize' do
    it 'parameterizes a simple string' do
      expect(described_class.parameterize('Hello World')).to eq('hello-world')
    end

    it 'removes special characters' do
      expect(described_class.parameterize('Hello, World!')).to eq('hello-world')
    end

    it 'uses custom separator' do
      expect(described_class.parameterize('Hello World', separator: '_')).to eq('hello_world')
    end

    it 'collapses multiple separators' do
      expect(described_class.parameterize('Hello   World')).to eq('hello-world')
    end
  end

  describe '.underscore' do
    it 'converts CamelCase to snake_case' do
      expect(described_class.underscore('UserAccount')).to eq('user_account')
    end

    it 'handles consecutive capitals' do
      expect(described_class.underscore('HTMLParser')).to eq('html_parser')
    end

    it 'converts hyphens to underscores' do
      expect(described_class.underscore('user-account')).to eq('user_account')
    end

    it 'handles namespaces' do
      expect(described_class.underscore('Admin::UserAccount')).to eq('admin/user_account')
    end
  end

  describe '.camelize' do
    it 'converts snake_case to CamelCase' do
      expect(described_class.camelize('user_account')).to eq('UserAccount')
    end

    it 'converts with lowercase first letter' do
      expect(described_class.camelize('user_account', uppercase_first: false)).to eq('userAccount')
    end

    it 'handles namespaced paths' do
      expect(described_class.camelize('admin/user_account')).to eq('Admin::UserAccount')
    end
  end

  describe '.humanize' do
    it 'humanizes an underscored string' do
      expect(described_class.humanize('user_account')).to eq('User Account')
    end

    it 'removes _id suffix' do
      expect(described_class.humanize('author_id')).to eq('Author')
    end

    it 'replaces underscores with spaces' do
      expect(described_class.humanize('first_name')).to eq('First Name')
    end
  end

  describe '.titleize' do
    it 'titleizes a string' do
      expect(described_class.titleize('user_account')).to eq('User Account')
    end

    it 'titleizes CamelCase' do
      expect(described_class.titleize('UserAccount')).to eq('User Account')
    end
  end

  describe '.ordinalize' do
    it 'converts 1 to 1st' do
      expect(described_class.ordinalize(1)).to eq('1st')
    end

    it 'converts 2 to 2nd' do
      expect(described_class.ordinalize(2)).to eq('2nd')
    end

    it 'converts 3 to 3rd' do
      expect(described_class.ordinalize(3)).to eq('3rd')
    end

    it 'converts 4 to 4th' do
      expect(described_class.ordinalize(4)).to eq('4th')
    end

    it 'converts 11 to 11th' do
      expect(described_class.ordinalize(11)).to eq('11th')
    end

    it 'converts 12 to 12th' do
      expect(described_class.ordinalize(12)).to eq('12th')
    end

    it 'converts 13 to 13th' do
      expect(described_class.ordinalize(13)).to eq('13th')
    end

    it 'converts 21 to 21st' do
      expect(described_class.ordinalize(21)).to eq('21st')
    end

    it 'converts 22 to 22nd' do
      expect(described_class.ordinalize(22)).to eq('22nd')
    end

    it 'converts 23 to 23rd' do
      expect(described_class.ordinalize(23)).to eq('23rd')
    end

    it 'converts 100 to 100th' do
      expect(described_class.ordinalize(100)).to eq('100th')
    end

    it 'converts 101 to 101st' do
      expect(described_class.ordinalize(101)).to eq('101st')
    end

    it 'converts 111 to 111th' do
      expect(described_class.ordinalize(111)).to eq('111th')
    end

    it 'converts 112 to 112th' do
      expect(described_class.ordinalize(112)).to eq('112th')
    end

    it 'converts 113 to 113th' do
      expect(described_class.ordinalize(113)).to eq('113th')
    end

    it 'handles 0' do
      expect(described_class.ordinalize(0)).to eq('0th')
    end

    it 'handles negative numbers' do
      expect(described_class.ordinalize(-1)).to eq('-1st')
      expect(described_class.ordinalize(-11)).to eq('-11th')
      expect(described_class.ordinalize(-21)).to eq('-21st')
    end
  end

  describe '.dasherize' do
    it 'converts underscored string to dashed' do
      expect(described_class.dasherize('some_thing')).to eq('some-thing')
    end

    it 'handles already dashed strings' do
      expect(described_class.dasherize('some-thing')).to eq('some-thing')
    end

    it 'handles strings without underscores' do
      expect(described_class.dasherize('something')).to eq('something')
    end

    it 'handles multiple underscores' do
      expect(described_class.dasherize('one_two_three')).to eq('one-two-three')
    end
  end

  describe '.demodulize' do
    it 'removes module namespace' do
      expect(described_class.demodulize('Admin::User')).to eq('User')
    end

    it 'handles deeply nested namespaces' do
      expect(described_class.demodulize('App::Admin::User')).to eq('User')
    end

    it 'returns the string when no namespace' do
      expect(described_class.demodulize('User')).to eq('User')
    end

    it 'handles empty string' do
      expect(described_class.demodulize('')).to eq('')
    end
  end

  describe '.deconstantize' do
    it 'removes the rightmost segment' do
      expect(described_class.deconstantize('Admin::User')).to eq('Admin')
    end

    it 'handles deeply nested namespaces' do
      expect(described_class.deconstantize('App::Admin::User')).to eq('App::Admin')
    end

    it 'returns empty string for non-namespaced constant' do
      expect(described_class.deconstantize('User')).to eq('')
    end

    it 'returns empty string for empty input' do
      expect(described_class.deconstantize('')).to eq('')
    end
  end

  describe '.upcase_first' do
    it 'uppercases the first character' do
      expect(described_class.upcase_first('hello world')).to eq('Hello world')
    end

    it 'leaves already uppercase strings unchanged' do
      expect(described_class.upcase_first('HELLO')).to eq('HELLO')
    end

    it 'preserves rest of string' do
      expect(described_class.upcase_first('hELLO')).to eq('HELLO')
    end

    it 'returns empty string for empty input' do
      expect(described_class.upcase_first('')).to eq('')
    end
  end

  describe '.add_irregular' do
    after do
      described_class.custom_plurals.shift
      described_class.custom_singulars.shift
    end

    it 'pluralizes an irregular word' do
      described_class.add_irregular('person', 'people')
      expect(described_class.pluralize('person')).to eq('people')
    end

    it 'singularizes an irregular word' do
      described_class.add_irregular('person', 'people')
      expect(described_class.singularize('people')).to eq('person')
    end

    it 'preserves original casing' do
      described_class.add_irregular('person', 'people')
      expect(described_class.pluralize('Person')).to eq('People')
    end
  end

  describe '.add_plural_rule' do
    after do
      described_class.custom_plurals.shift
    end

    it 'adds a custom pluralization rule with regex' do
      described_class.add_plural_rule(/foo$/i, 'fooze')
      expect(described_class.pluralize('foo')).to eq('fooze')
    end

    it 'adds a custom pluralization rule with string' do
      described_class.add_plural_rule('bar$', 'barz')
      expect(described_class.pluralize('bar')).to eq('barz')
    end

    it 'gives priority to custom rules' do
      described_class.add_plural_rule(/^cat$/i, 'kittens')
      expect(described_class.pluralize('cat')).to eq('kittens')
    end
  end

  describe '.add_singular_rule' do
    after do
      described_class.custom_singulars.shift
    end

    it 'adds a custom singularization rule with regex' do
      described_class.add_singular_rule(/fooze$/i, 'foo')
      expect(described_class.singularize('fooze')).to eq('foo')
    end

    it 'adds a custom singularization rule with string' do
      described_class.add_singular_rule('barz$', 'bar')
      expect(described_class.singularize('barz')).to eq('bar')
    end
  end

  describe '.add_uncountable' do
    after do
      described_class.custom_uncountables.pop
    end

    it 'adds a custom uncountable word' do
      described_class.add_uncountable('funky')
      expect(described_class.pluralize('funky')).to eq('funky')
      expect(described_class.singularize('funky')).to eq('funky')
    end

    it 'adds multiple uncountable words' do
      described_class.add_uncountable('alpha', 'beta')
      expect(described_class.pluralize('alpha')).to eq('alpha')
      expect(described_class.pluralize('beta')).to eq('beta')
      described_class.custom_uncountables.pop
    end
  end
end
