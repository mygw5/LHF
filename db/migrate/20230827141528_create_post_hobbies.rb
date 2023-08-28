class CreatePostHobbies < ActiveRecord::Migration[6.1]
  def change
    create_table :post_hobbies do |t|
      t.string  :title,  null: false
      t.text    :text,   null: false
      t.boolean :status, null: false
      t.timestamps
    end
  end
end
