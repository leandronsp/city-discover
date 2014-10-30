class AddEarthdistanceIndexToCities < ActiveRecord::Migration
  def change
    add_earthdistance_index :cities,
      lat: :latitude, lng: :longitude
  end
end
