module Ribernate::Model
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_persisted(*attrs)
      attrs.each do |a|
        define_method("_" + a.to_s) do
          eval "@#{a.to_s}"
        end
      end

      define_method(:_persisted_columns) do
        attrs.inject({}) {|hsh, a| hsh[a] = send("_" + a.to_s); hsh }
      end
    end
  end
end
