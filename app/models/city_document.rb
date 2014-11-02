class CityDocument < ActiveRecord::Base
  include PgSearch

  acts_as_geolocated

  self.table_name = 'city_document_view'
  self.primary_key = 'city_id'

  def self.rank_script
    script = <<-SCRIPT
      :tsearch * log(GREATEST(CAST(population AS integer), 3))
    SCRIPT

    script.gsub("\n", '').gsub(/\s{2,}/, ' ').strip
  end

  def self.rank_with_coords_script(lat, lon)
    script = <<-SCRIPT
      :tsearch * log(GREATEST(CAST(population AS integer), 3))
               * (3.0 ^ (CAST((point(latitude,longitude) <@> point(#{lat}, #{lon})) AS numeric) + 1.0) ^ -0.1)
    SCRIPT

    script.gsub("\n", '').gsub(/\s{2,}/, ' ').strip
  end

  pg_search_scope :_search,
    against: {
      city_name: 'A',
      aliases: 'B',
      region_name: 'C',
      country_name: 'D'
    },
    ignoring: :accents,
    ranked_by: self.rank_script,
    order_within_rank: 'pg_search_rank DESC'

  pg_search_scope :_fuzzy_search,
    against: :city_name,
    using: {
      tsearch: { dictionary: 'simple', prefix: true, any_word: true },
      trigram: { only: [:city_name], threshold: 0.5 }
    },
    ignoring: :accents,
    ranked_by: self.rank_script,
    order_within_rank: 'pg_search_rank DESC'

  pg_search_scope :_search_with_coords, (lambda do |term, lat, lon|
    {
      query: term,
      against: {
        city_name: 'A',
        aliases: 'B',
        region_name: 'C',
        country_name: 'D'
      },
      ignoring: :accents,
      ranked_by: self.rank_with_coords_script(lat, lon),
      order_within_rank: 'pg_search_rank DESC'
    }
  end)

  def readonly?
    true
  end

  def self.refresh_view
    connection = ActiveRecord::Base.connection
    connection.execute('REFRESH MATERIALIZED VIEW city_document_view')
  end

end
