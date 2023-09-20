class AddUserIdToItems < ActiveRecord::Migration[6.1]
  def up
    add_reference :items, :user, null: false, index: true
  end

  def down
    remove_reference :items, :user, index: true
  end
end
