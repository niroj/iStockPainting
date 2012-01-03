class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :title
      t.integer :credits
      t.references :user

      t.timestamps
    end
    add_index :paintings, :user_id
  end
end
