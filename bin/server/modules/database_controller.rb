# frozen_string_literal: true

require 'sequel'

# Handles the applications wide integration with the database
class DatabaseController
  # Configuration
  DB = if ENV['RACK_ENV'] == 'production'
         Sequel.connect(ENV['DATABASE_URL'])
       else
         Sequel.sqlite('./db/data.db')
       end

  # Initializes a new instance of an object and sets provided data
  #
  # Params - Hash
  #
  # Returns instance of class with instance_variables set according to params
  def initialize(params = {})
    raise 'Wrong data provided' unless params.is_a? Hash

    params = params.to_h.stringify_keys
    set_instance_variable_params(params)
    set_instance_variable_columns(params)
  end

  # rubocop:disable Naming/AccessorMethodName
  def set_instance_variable_columns(params)
    return if self.class.columns.nil?

    self.class.columns.each do |x|
      unless params.include?(x.to_s)
        instance_variable_set("@#{x.to_s.gsub(':', '')}", nil)
        singleton_class.send(:attr_accessor, x.to_s.gsub(':', ''))
      end
    end
  end

  def set_instance_variable_params(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
      singleton_class.send(:attr_accessor, key.to_s)
    end
  end
  # rubocop:enable Naming/AccessorMethodName

  #############################################################
  ##### Getter/Setters configuration ####
  #############################################################
  # Setter
  # rubocop:disable Naming/AccessorMethodName
  def self.set_table(symbol)
    @table = symbol
  end
  # rubocop:enable Naming/AccessorMethodName

  # Getter
  class << self
    attr_reader :table
  end

  # Setter
  # rubocop:disable Naming/AccessorMethodName
  def self.set_columns(*symbols)
    @columns = symbols
  end
  # rubocop:enable Naming/AccessorMethodName

  # Getter
  class << self
    attr_reader :columns
  end

  def self.select_dataset(table = nil)
    if !table.nil?
      DB[:"#{table}"]
    elsif !self.table.nil?
      DB[:"#{self.table}"]
    else
      DB[:"#{to_s.downcase}"]
    end
  end

  def select_dataset(table = nil)
    if !table.nil?
      DB[:"#{table}"]
    elsif !self.class.table.nil?
      DB[:"#{self.class.table}"]
    else
      DB[:"#{to_s.downcase}"]
    end
  end

  #############################################################
  ##### General methods ####
  #############################################################

  # Fetches data from the database where the conditions apply
  #
  # conditions - Hash (Conditions for fetching from db)
  # table - String (Optional table)
  #
  # Returns a array of objects
  def self.fetch_where(conditions, object = true, table = nil)
    dataset = select_dataset(table)
    if object
      dataset.where(conditions).all.objectify(self)
    else
      dataset.where(conditions).all
    end
  end

  # Initializes Sequel instance for provided table
  #
  # table - String (Optional table)
  #
  # Returns Sequel instance based on class table
  def self.fetch_dataset(table = nil)
    select_dataset(table)
  end

  # Returns all elements from database table
  #
  # table - String (Optional table)
  #
  # Returns Array of objects from database
  def self.fetch_all(object = true, table = nil)
    dataset = select_dataset(table)
    if object
      dataset.all.objectify(self)
    else
      dataset.all
    end
  end

  def delete
    self.class.fetch_dataset.where(id: @id).delete
  end

  # Saves a instance to the database
  #
  # table - String (Optional table)
  #
  # returns nothing
  # rubocop:disable Metrics/AbcSize
  def save(table = nil)
    # Converts object to hash
    hash = {}
    instance_variables.map { |q| hash[q.to_s.gsub('@', '')] = instance_variable_get(q) }

    dataset = select_dataset(table)
    hash['body'] = hash['body'].to_s if hash['body']

    if instance_variables.include?(:@id) && id.is_a?(Integer)
      # Object has a id and thereby is only updated
      dataset.where(id: id).update(hash)
    else
      # Object is inserted into database
      DB.transaction do
        hash.delete('id')
        dataset.insert(hash)
        # Retrives the new id
        if self.class.columns.include?(:id)
          id = dataset.limit(1).order(:id).reverse
          instance_variable_set(:@id, id.first[:id])
        end
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize

# Provides additional functionality for Hash elements
class Hash
  # Loops over the keys in a hash and yields block
  #
  # block - Does something to the key
  #
  # Returns yielded result
  def transform_keys
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end

  # Converts hash keys to strings
  #
  # Returns a new hash containing stringlified keys
  def stringify_keys
    transform_keys(&:to_s)
  end

  # Objectifies a input hash
  def objectify(clazz)
    clazzer = if Array.class_exists?(clazz)
                Object.const_get(clazz)
              else
                ClassFactory.create_class clazz.downcase.capitalize, ApplicationController
              end
    clazzer.new self
  end
end

# Provides additional functionality to Arrays
class Array
  def objectify(clazz)
    clazz = clazz.to_s if clazz.class == Class
    objects = []
    clazzer = if Array.class_exists?(clazz)
                Object.const_get(clazz)
              else
                ClassFactory.create_class clazz.downcase.capitalize, ApplicationController
              end

    each do |element|
      objects << clazzer.new(element)
    end
    objects
  end

  # Checks if a class is defined
  #
  # class_name - (String) Class name. Case sensetive
  #
  # Returns true or false
  def self.class_exists?(class_name)
    klass = Module.const_get(class_name)
    klass.is_a?(Class)
  rescue NameError
    false
  end
end
