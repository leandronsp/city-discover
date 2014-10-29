class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :geonameid
      t.integer :country_id
      t.string :concatenated_codes
      t.string :isocode

      t.timestamps
    end

    add_index :regions, :geonameid, unique: true
  end
end
