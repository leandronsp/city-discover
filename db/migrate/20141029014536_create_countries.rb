class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :slug
      t.string :isocode
      t.string :geonameid
      t.string :population
      t.string :continent
      t.string :neighbours

      t.timestamps
    end

    add_index :countries, :geonameid, unique: true
    add_index :countries, :isocode, unique: true
    add_index :countries, :slug, unique:true
  end
end
