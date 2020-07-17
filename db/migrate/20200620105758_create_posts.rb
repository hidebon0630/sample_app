class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, [:user_id, :created_at]
  end
end
