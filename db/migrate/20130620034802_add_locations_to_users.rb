class AddLocationsToUsers < ActiveRecord::Migration
  change_table :locations do |t| 
    t.references :user
  end
end
