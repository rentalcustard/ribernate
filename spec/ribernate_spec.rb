require 'spec_helper'

class UserDAO
  include Ribernate::DAOMethods
end

class User
  include Ribernate::Model
  attr_persisted :name, :id

  def initialize
    @name = "foo"
    @id = 5
    @created_at = Time.now
  end
end


Arel::Table.engine = Arel::Sql::Engine.new(FakeRecord::Base.new)

describe "Ribernate behaviours" do
  subject { UserDAO.new }

  describe "persisting an object" do
    it "sends a query to the database with each persisted attribute, and no others" do
      user = User.new
      subject.save(user)
      Ribernate::DB.engine.sent_queries.should include('INSERT INTO "users" ("name", "id") VALUES (\'foo\', 5)')
    end
  end
end
