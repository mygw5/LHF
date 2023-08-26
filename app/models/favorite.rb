class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :hobby

  validates_uniqueness_of :hobby_id, scope: :user_id
end
