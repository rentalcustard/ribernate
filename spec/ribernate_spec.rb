require File.dirname(__FILE__) + "/../lib/ribernate"
require 'support/fake_record'
class UserDAO
  include Ribernate::DAOMethods

  persists :users #should this be optional?
end

class User
  include Ribernate::Model
  attr_persisted :name

  def initialize
    @name = "foo"
  end
end

Arel::Table.engine = Arel::Sql::Engine.new(FakeRecord::Base.new)

describe "Ribernate behaviours" do
  subject { UserDAO.new }

  describe "persisting an object" do
    it "doesn't explode" do
      user = User.new
      subject.save(user)
    end
  end
end
