class City < ActiveRecord::Base
  include PgSearch

  belongs_to :region
  belongs_to :country

  has_many :city_aliases

  pg_search_scope :_search, associated_against: {
    region: :name,
    country: :name,
    city_aliases: [:name]
  },
  using: [:tsearch, :dmetaphone, :trigram],
  ignoring: :accents
end
