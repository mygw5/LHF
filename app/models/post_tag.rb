class PostTag < ApplicationRecord
  belongs_to :post_hobby
  belongs_to :tag
end
