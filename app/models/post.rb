class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :cover_photo
  validates :category, presence: true
  validates :title, presence: true

  enum category: { guide: 'guide', review: 'review', interview:'interview' }
  
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def saved?(current_user)
    @saved_post = SavedPost.find_by(user_id: current_user.id, post_id: self.id)
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  def tags_to_string
    self.tags.pluck(:name).join(", ")
  end
end
