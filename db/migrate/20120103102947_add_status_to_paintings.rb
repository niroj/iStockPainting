class AddStatusToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :status, :boolean, :default => true
  end
end
