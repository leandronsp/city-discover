class CitiesController < ApplicationController
  def search
    results = City._search(params[:term])

    if results.blank?
      results = City._fuzzy_search(params[:term])
    end

    render json: results
  end
end
