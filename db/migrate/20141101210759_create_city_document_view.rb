class CreateCityDocumentView < ActiveRecord::Migration
  reversible do |dir|
    dir.up do
      execute <<-SQL
        CREATE MATERIALIZED VIEW city_document_view AS
          SELECT cities.id as city_id,
          cities.name as city_name,
          cities.population as population,
          cities.longitude as longitude,
          cities.latitude as latitude,
          regions.name as region_name,
          regions.isocode as region_isocode,
          countries.name as country_name,
          countries.isocode as country_isocode,
          string_agg(city_aliases.name, ' ') as aliases
          FROM cities
          JOIN regions ON cities.region_id = regions.id
          JOIN countries ON cities.country_id = countries.id
          JOIN city_aliases ON cities.id = city_aliases.city_id
          GROUP BY cities.id, regions.id, countries.id;
        SQL

      execute <<-SQL
        CREATE INDEX city_document_view_earthdistance_idx ON city_document_view USING gist (ll_to_earth(latitude, longitude));
      SQL
    end

    dir.down do
      execute <<-SQL
        DROP INDEX city_document_view_earthdistance_idx;
        DROP MATERIALIZED VIEW IF EXISTS city_document_view;
      SQL
    end
  end
end
