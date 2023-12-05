class AddAvailabilityToShoppingList < ActiveRecord::Migration[6.1]
  def change
    add_column :shopping_lists, :availability, :boolean, default: false, null: false
  end
end
