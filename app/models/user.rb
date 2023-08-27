class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_hobbies
  has_many :comments,    dependent: :destroy
  has_many :favorites,   dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :chats

  has_one_attached :profile_image

  validates :name,  length: { minimum:2, maximum:20 }, uniqueness: true
  validates :hobby, presence: true
end
