class CitiesController < ApplicationController
  def search
    render json: City._search(params[:term])
  end
end
