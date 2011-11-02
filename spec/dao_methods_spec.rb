module Ribernate; end
require 'active_support'
require File.dirname(__FILE__) + "/../lib/ribernate/dao_methods"
class WidgetDAO
  include Ribernate::DAOMethods
end

class BarDAO
  include Ribernate::DAOMethods
  persists :bears
end

describe Ribernate::DAOMethods do
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
