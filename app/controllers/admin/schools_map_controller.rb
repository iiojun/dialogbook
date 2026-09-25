class Admin::SchoolsMapController < ApplicationController
  def index
    @school_sites = SchoolSite.where.not(latitude: nil, longitude: nil)
  end
end
