class City < ActiveRecord::Base
  include PgSearch

  belongs_to :region
  belongs_to :country

  has_many :city_aliases

  pg_search_scope :_search,
    against: { name: 'A' },
    associated_against: {
      region: { name: 'C' },
      country: { name: 'D' },
      city_aliases: { name: 'B' }
    },
    ignoring: :accents,
    using: { tsearch: { only: [:name] }},
    ranked_by: 'log(GREATEST(CAST(cities.population AS integer), 3)) * :tsearch',
    order_within_rank: 'pg_search_rank DESC'

  pg_search_scope :_fuzzy_search,
    against: :name,
    using: {
      tsearch: { dictionary: 'simple' },
      trigram: { only: [:name], threshold: 0.5 }
    },
    ignoring: :accents,
    ranked_by: 'log(GREATEST(CAST(cities.population AS integer), 3)) * :tsearch',
    order_within_rank: 'pg_search_rank DESC'
end
