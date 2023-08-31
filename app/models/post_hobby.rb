class PostHobby < ApplicationRecord

  belongs_to  :user

  has_many  :comments,  dependent: :destroy
  has_many  :favorites, dependent: :destroy
  has_many  :post_tags, dependent: :destroy
  has_many  :tags,      through:   :post_tags

  has_one_attached :image, dependent: :destroy

  validates  :title,    presence: true
  validates  :text,     presence: true, length:{maximum:200}


  enum post_status: { published: 0, draft: 1 }

  def save_draft
    self.post_status = :draft
    save(validate: false)
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


  def save_tags(sent_tags)
    # 現在のユーザーの持っているskillを引っ張ってきている
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 今持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - sent_tags
    # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
    new_tags = sent_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << tag
    end
  end

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end




end

