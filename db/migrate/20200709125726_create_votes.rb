class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :option, foreign_key: true
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :votes, [:user_id, :post_id], unique: true
  end
end
