module Ribernate
  class DB
    def self.engine
      @@db ||= new
    end
    
    def initialize
      @sent_queries = []
    end

    def exec(query)
      @sent_queries << query
    end

    attr_reader :sent_queries
  end
end

require File.dirname(__FILE__) + "/../lib/ribernate"
require 'support/fake_record'
