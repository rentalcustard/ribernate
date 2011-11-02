require 'active_support'
module Ribernate; end
require File.dirname(__FILE__) + "/../lib/ribernate/model"

class User
  include Ribernate::Model

  attr_persisted :name
end

describe Ribernate::Model do
  subject { User.new }

  describe ".attr_persisted" do
    it "doesn't create default accessors" do
      expect { subject.name }.to raise_error(NoMethodError)
      expect { subject.name=("wut") }.to raise_error(NoMethodError)
    end

    it "doesn't fudge the issue" do
      expect { subject._name }.to raise_error(NoMethodError)
    end
  end
end
