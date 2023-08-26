class Tag < ApplicationRecord
  has_many :hobby, dependent: :destroy

  validates :tag, presence: true, uniqueness: true
end
