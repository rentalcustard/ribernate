module Ribernate::DAOMethods
  extend ActiveSupport::Concern

  module ClassMethods
    def persists(table_name)
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
