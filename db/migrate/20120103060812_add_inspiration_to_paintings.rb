class AddInspirationToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :inspiration, :text
  end
end
