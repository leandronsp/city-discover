class CityDocument < ActiveRecord::Base
  include PgSearch

  acts_as_geolocated

  self.table_name = 'city_document_view'
  self.primary_key = 'city_id'

  pg_search_scope :_search,
    against: {
      city_name: 'A',
      aliases: 'B',
      region_name: 'C',
      country_name: 'D'
    },
    ignoring: :accents,
    ranked_by: 'log(GREATEST(CAST(population AS integer), 3)) * :tsearch',
    order_within_rank: 'pg_search_rank DESC'

  pg_search_scope :_fuzzy_search,
    against: :city_name,
    using: {
      tsearch: { dictionary: 'simple' },
      trigram: { only: [:city_name], threshold: 0.5 }
    },
    ignoring: :accents,
    ranked_by: 'log(GREATEST(CAST(population AS integer), 3)) * :tsearch',
    order_within_rank: 'pg_search_rank DESC'

  def readonly?
    true
  end

  def self.refresh_view
    connection = ActiveRecord::Base.connection
    connection.execute('REFRESH MATERIALIZED VIEW city_document_view')
  end
end
