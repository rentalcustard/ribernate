module Ribernate; end
require 'active_support'
require File.dirname(__FILE__) + "/../lib/ribernate/dao"
class WidgetDAO
  include Ribernate::DAO
end

class BarDAO
  include Ribernate::DAO
  persists :bears
end

describe Ribernate::DAO do
  context "with implicit table name" do
    subject { WidgetDAO.new }
    it "sets the table name based on class name" do
      subject.instance_eval("table_name").should eq("widgets")
    end
  end

  context "with explicit table name" do
    subject { BarDAO.new }
    it "sets the table name based on class name" do
      subject.instance_eval("table_name").should eq("bears")
    end
  end
end
