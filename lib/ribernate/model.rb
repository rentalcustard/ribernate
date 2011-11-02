module Ribernate::Model
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_persisted(*attrs)
      define_method(:persisted_columns) do
        attrs.inject({}) {|hsh, a| hsh[a] = instance_variable_get("@" + a.to_s); hsh }
      end
      private :persisted_columns
    end
  end
end
