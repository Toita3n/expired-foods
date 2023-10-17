class AddAccessTokenToAuthentications < ActiveRecord::Migration[6.1]
  def change
    add_column :authentications, :access_token, :string, null: false
    add_column :authentications, :access_token_secret, :string, null: false
  end
end
