require 'active_support/inflector'
module Ribernate::DAO
  extend ActiveSupport::Concern

  included do
    define_method :table_name do
      self.class.to_s.gsub("DAO", "").downcase.pluralize
    end

    define_method :table do
      @table ||= Arel::Table.new(table_name)
    end

    define_method :inserter do
      @inserter ||= Arel::InsertManager.new table.engine
    end

    define_method :db do
      @db ||= Ribernate::DB.engine
    end
  end

  module ClassMethods
    def persists(name)
      define_method :table_name do
        name.to_s
      end
    end
  end

  def save(model)
    inserter.into table
    insertion = model.send(:persisted_columns).map do |col, val|
      [table[col], val]
    end
    inserter.insert(insertion)
    db.exec(inserter.to_sql)
  end
end
