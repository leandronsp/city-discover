class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :slug
      t.integer :country_id
      t.integer :region_id
      t.float :latitude
      t.float :longitude
      t.string :population
      t.string :geonameid
      t.string :timezone
      t.boolean :capital, default: false
      t.boolean :capital_district, default: false

      t.timestamps
    end

    add_index :cities, :country_id
    add_index :cities, :geonameid, unique: true
    add_index :cities, :slug
  end
end
