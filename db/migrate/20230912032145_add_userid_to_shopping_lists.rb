class AddUseridToShoppingLists < ActiveRecord::Migration[6.1]
  def change
    add_reference :shopping_lists, :user, null: false, foreign_key: true
  end
end
