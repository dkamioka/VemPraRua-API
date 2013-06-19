class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :fbuid
      t.string :regid

      t.timestamps
    end
  end
end
