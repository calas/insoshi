require File.dirname(__FILE__) + '/../spec_helper'

describe BlogPost do
  
  before(:each) do
    @post = BlogPost.new(:title => "First post!",
                         :body => "Hey there",
                         :blog => blogs(:one))
  end
  
  it "should be valid" do
    @post.should be_valid
  end
  
  it "should require a title" do
    post = BlogPost.new
    post.should_not be_valid
    post.errors.on(:title).should_not be_empty
  end
  
  it "should require a body" do
    post = BlogPost.new
    post.should_not be_valid
    post.errors.on(:body).should_not be_empty
  end
  
  it "should have a maximum body length" do
    @post.should have_maximum(:body, BlogPost::MAX_BODY)
  end
    
  describe "post activity associations" do
    
    before(:each) do
      @post.save!
      @activity = Activity.find_by_item_id(@post)
    end
    
    it "should have an activity" do
      @activity.should_not be_nil
    end
    
    it "should add an activity to the poster" do
      @post.blog.person.activities.include?(@activity).should == true
    end
  end
  
  describe "comment associations" do
    
    before(:each) do
      @post.save
      @post.comments.create(:body => "The body",
                            :commenter => people(:aaron))
    end
    
    it "should have associated comments" do
      @post.comments.should_not be_empty
    end
    
    it "should add activities to the poster" do
      @post.comments.each do |comment|
        activity = Activity.find_by_item_id(comment)
        @post.blog.person.activities.include?(activity).should == true
      end
    end
  end
end
