class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string :email, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
