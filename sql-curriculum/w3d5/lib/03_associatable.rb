require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name = options[:class_name] || name.to_s.camelcase
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
    @foreign_key = options[:foreign_key] || "#{self_class_name.underscore}_id".to_sym
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)

    define_method name do
      foreign_val = send(options.foreign_key)
      class_name = options.model_class
      class_name.where(options.primary_key => foreign_val).first
    end

    assoc_options[name] = options
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)

    define_method name do
      primary_val = send(options.primary_key)
      class_name = options.model_class
      class_name.where(options.foreign_key => primary_val)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
