class City < ActiveRecord::Base
  acts_as_geolocated

  belongs_to :region
  belongs_to :country

  has_many :city_aliases
end
