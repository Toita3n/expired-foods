class AddUseridToShoppingLists < ActiveRecord::Migration[6.1]
  def up
    add_reference :shopping_lists, :user, null: false, index: true
  end

  def down
    remove_reference :shopping_lists, :user, index: true
  end
end
