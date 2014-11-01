class CitiesController < ApplicationController
  def search
    render json: scope._search(params[:term]).presence ||
                 scope._fuzzy_search(params[:term])
  end

  private

  def scope
    if params[:location].present?
      CityDocument.within_radius(radius, params[:location][:lat], params[:location][:lon])
    else
      CityDocument
    end
  end

  def radius
    params[:radius].presence || 50000
  end
end
