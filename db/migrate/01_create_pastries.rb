class CreatePastries < ActiveRecord::Migration
  def change
    create_table :pastries do |t|
      t.integer :user_id
      t.string :name
      t.text :ingredients
      t.text :kitchenware
      t.text :directions
      t.string :price_range
    end
  end
end
