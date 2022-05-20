require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @post = create(:post)
  end

  it "is valid with valid attributes" do
    expect(@post).to be_valid
  end

  it "is invalid with invalid attributes" do
    @post.update(category: nil)
    expect(@post).not_to be_valid
  end

  describe '#tag_list=' do
    it 'creates a tag that does not exist yet' do
      @post.tag_list = "thai"

      expect(Tag.count).to be(1)
    end

    it 'finds an existing tag' do
      tag_that_already_exists = create(:tag, name: "antwerp")
      
      @post.tag_list = "antwerp"
      expect(@post.tags.first).to eq(tag_that_already_exists)
    end

    it 'works with multiple existing and non-existing tags combined' do
      tag_that_already_exists = create(:tag, name: "thai")
      another_tag_that_already_exists = create(:tag, name: "antwerp")

      @post.tag_list = "thai, antwerp, breakfast, dinner"
      expect(@post.tags.pluck(:name)).to eq(["thai", "antwerp", "breakfast", "dinner"])
      expect(@post.tags).to include(tag_that_already_exists, another_tag_that_already_exists)
    end
  end

  describe '#tags_to_string' do
    it 'turns a single tag to a string without a comma' do
      tag = create(:tag, name: "antwerp")
      post = create(:post, tags: [tag])

      expect(post.tags_to_string).to eq("antwerp")
    end

    it 'turns multiple tags in a correct string' do
      tag1 = create(:tag, name: "antwerp")
      tag2 = create(:tag, name: "brunch")
      tag3 = create(:tag, name: "thai")
      post = create(:post, tags: [tag1, tag2, tag3])

      expect(post.tags_to_string).to eq("antwerp, brunch, thai")
    end

    it 'can take an empty tag list' do
      post = create(:post)

      expect(post.tags_to_string).to eq("")
    end
  end
end