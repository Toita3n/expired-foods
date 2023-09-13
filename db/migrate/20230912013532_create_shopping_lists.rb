class CreateShoppingLists < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_lists do |t|
      t.string :product
      t.integer :number
      t.text :trait

      t.timestamps
    end
  end
end
