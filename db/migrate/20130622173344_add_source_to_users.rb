class AddSourceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :source, :string 
    add_column :users, :ip_address, :string
  end
end
