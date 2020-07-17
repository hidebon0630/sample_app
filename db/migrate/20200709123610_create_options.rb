class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :title

      t.timestamps
    end
    add_index :options, :post_id
    add_index :options, :user_id
  end
end
