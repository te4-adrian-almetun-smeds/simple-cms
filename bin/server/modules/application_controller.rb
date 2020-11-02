# frozen_string_literal: true

# Handles application wide integration with a database
class ApplicationController
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
  def initialize(params)
    raise 'No data provided' unless params.is_a? Hash

    params = params.to_h.stringify_keys

    params.each do |key, value|
      instance_variable_set("@#{key}", value)
      singleton_class.send(:attr_accessor, key.to_s)
    end
    self.class.columns.each do |x|
      unless params.include?(x.to_s)
        instance_variable_set("@#{x.to_s.gsub(':', '')}", nil)
        singleton_class.send(:attr_accessor, x.to_s.gsub(':', ''))
      end
    end
  end

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

  def select_dataset(table)
    if !table.nil?
      DB[:"#{table}"]
    elsif !self.table.nil?
      DB[:"#{self.table}"]
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
  def self.where(conditions, table = nil)
    dataset = select_dataset(table)
    dataset.where(conditions)
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
  # Returns Array of elements from database
  def self.fetch_all(table = nil)
    dataset = select_dataset(table)
    dataset.all
  end

  # Saves a instance to the database
  #
  # table - String (Optional table)
  #
  # returns nothing
  def save(table = nil)
    # Converts object to hash
    hash = {}
    instance_variables.map { |q| hash[q.to_s.gsub('@', '')] = instance_variable_get(q) }

    dataset = select_dataset(table)

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
