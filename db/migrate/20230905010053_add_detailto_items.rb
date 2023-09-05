class AddDetailtoItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :detail, :string
  end
end
