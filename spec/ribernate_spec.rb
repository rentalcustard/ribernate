require File.dirname(__FILE__) + "/../lib/ribernate"
class PostDAO
  include Ribernate::DAOMethods

  persists :posts
end

class Post
end

describe "Ribernate behaviours" do
  subject { PostDAO.new }

  describe "persisting an object" do
    it "doesn't explode" do
      post = Post.new
      subject.save(post)
    end
  end
end
