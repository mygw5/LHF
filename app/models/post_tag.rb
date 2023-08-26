class PostTag < ApplicationRecord
  belongs_to :hobby
  belongs_to :tag
end
