class CreateCityAliases < ActiveRecord::Migration
  def change
    create_table :city_aliases do |t|
      t.integer :city_id
      t.string :name
      t.string :locale

      t.timestamps
    end

    add_index :city_aliases, :city_id
  end
end
