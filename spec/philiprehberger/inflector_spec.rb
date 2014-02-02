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
end
