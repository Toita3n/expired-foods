class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :count
      t.datetime :expired_at
      t.string :image

      t.timestamps
    end
  end
end
