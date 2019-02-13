class CreatePastries < ActiveRecord::Migration
  def change
    create_table :pastries do |t|
      t.string :name
      t.text :ingredients
      t.text :added_kitchenware
      t.text :directions
      t.string :price_range
    end
  end
end
