class PostHobby < ApplicationRecord

  belongs_to  :user

  has_many  :comments,  dependent: :destroy
  has_many  :favorites, dependent: :destroy
  has_many  :post_tags, depandent: :destroy

  has_many  :tags, through: :post_tags, source: :tag

  has_one_attached :image

  validates  :title, presence: true
  validates  :text,  presence: true, length:{maximum:200}

   def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
   end



end

