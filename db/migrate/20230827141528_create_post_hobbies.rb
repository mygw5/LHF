class CreatePostHobbies < ActiveRecord::Migration[6.1]
  def change
    create_table :post_hobbies do |t|
      t.string  :title,  null: false
      t.text    :text,   null: false
      t.integer :status, null: false, default: 0
      t.integer :user_id
      t.timestamps
    end
  end
end
