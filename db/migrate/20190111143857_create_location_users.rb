class CreateLocationUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :location_users do |t|
	  t.references :location
      t.references :user
      t.timestamps
    end
  end
end
