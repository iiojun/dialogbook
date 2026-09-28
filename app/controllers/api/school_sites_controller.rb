class Api::SchoolSitesController < ApplicationController
  def index
    render json: SchoolSite.all.as_json(
      only: [ :id, :name, :address, :latitude, :longitude, :time_zone,
              :site_type, :year_of_first_participation ])
  end
end
