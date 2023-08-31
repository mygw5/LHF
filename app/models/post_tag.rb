class PostTag < ApplicationRecord
  belongs_to :post_hobby
  belongs_to :tag
  validates :post_hobby_id, presence: true
  validates :tag_id, presence: true
end
