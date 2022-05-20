require "rails_helper"

RSpec.describe PostsController, :type => :controller do

  describe "GET guides" do
    it "has a 200 status code" do
      get :guides
      expect(response.status).to eq(200)
    end

    it "assigns a post to @guides" do
      post = Post.create(title:'hello', category: 'guide')
      get :guides
      expect(assigns(:guides)).to eq([post])
    end

    it "doesn't assign an interview to @guides" do
      post = Post.create(title: 'an interview', category: 'interview')
      get :guides
      expect(assigns(:guides)).not_to eq([post])
    end

    it "can contain multiple guides" do
      guide = Post.create(title: 'a guide', category: 'guide')
      guide_2 = Post.create(title: 'another guide', category: 'guide')
      interview = Post.create(title: 'an interview', category: 'interview')

      get :guides
      
      expect(assigns(:guides)).to eq([guide, guide_2])
    end
  end

  describe "GET review" do
    it "has a 200 status code" do
      get :reviews
      expect(response.status).to eq(200)
    end

    it "assigns a post to @review" do
      post = Post.create(title:'hello', category: 'review')
      get :reviews
      expect(assigns(:reviews)).to eq([post])
    end

    it "doesn't assign an interview to @guides" do
      post = Post.create(title: 'an interview', category: 'interview')
      get :reviews
      expect(assigns(:reviews)).not_to eq([post])
    end

    it "can contain multiple reviews" do
      review = Post.create(title: 'a review', category: 'review')
      review_2 = Post.create(title: 'another review', category: 'review')
      interview = Post.create(title: 'an interview', category: 'interview')

      get :reviews
      
      expect(assigns(:reviews)).to eq([review, review_2])
    end
  end
  
  describe "GET interviews" do
    it "assigns an interview to @interviews" do
      post = Post.create(title:'hello', category:'interview')
      get :interviews
      expect(assigns(:interviews)).to eq([post])
    end

    it "doesn't assign an guide to @interviews" do
      post = Post.create(title: 'a guide', category: 'guide')
      get :interviews
      expect(assigns(:reviews)).not_to eq([post])
    end

    it "can contain multiple interviews" do
      interview = Post.create(title: 'a interview', category: 'interview')
      interview_2 = Post.create(title: 'another interview', category: 'interview')
      review = Post.create(title: 'an review', category: 'review')

      get :interviews
      
      expect(assigns(:interviews)).to eq([interview, interview_2])
    end
  end


  describe "GET food" do
    it "has a 200 status code" do
      get :food
      expect(response.status).to eq(200)
    end

    it "assigns the correct types to food_posts" do
      interview = Post.create(title:'hello', category:'interview')
      guide = Post.create(title: 'a guide', category: 'guide')
      review = Post.create(title: 'a review', category: 'review')

      get :food

      expect(assigns(:food_posts)).to eq([guide, review])
    end
  end
end