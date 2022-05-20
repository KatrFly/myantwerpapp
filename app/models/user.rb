class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :email, presence: true

  has_many :comments, dependent: :destroy
  has_many :saved_posts, dependent: :destroy
  has_many :posts_saved, through: :saved_posts, source: :post
end
