class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :option_id
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
    add_index :votes, :option_id
    add_index :votes, :post_id
    add_index :votes, :user_id
    add_index :votes, [:user_id, :post_id], unique: true
  end
end
