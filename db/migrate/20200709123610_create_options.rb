class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
