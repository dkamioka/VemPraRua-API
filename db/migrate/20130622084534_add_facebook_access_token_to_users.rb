class AddFacebookAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fbat, :string
  end
end
