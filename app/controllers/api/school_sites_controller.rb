class Api::SchoolSitesController < ApplicationController
  def index
    render json: SchoolSite.all
  end
end
