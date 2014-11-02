class CitiesController < ApplicationController
  def search
    render json: basic_search.presence || fuzzy_search
  end

  private

  def scope
    if params[:location].present?
      lat, lon = params[:location].values_at(:lat, :lon)
      CityDocument.within_radius(radius, lat, lon)
    else
      CityDocument
    end
  end

  def basic_search
    if params[:location].present?
      lat, lon = params[:location].values_at(:lat, :lon)
      scope._search_with_coords(params[:term], lat, lon)
    else
      scope._search(params[:term])
    end
  end

  def fuzzy_search
    scope._fuzzy_search(params[:term])
  end

  def radius
    params[:radius].presence || 50000
  end
end
