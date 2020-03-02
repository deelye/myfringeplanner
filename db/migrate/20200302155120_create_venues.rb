class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :space
      t.string :address
      t.string :postcode
      t.float :longitude
      t.float :latitude
      t.boolean :wheelchair_access
      t.text :disabled_description

      t.timestamps
    end
  end
end
