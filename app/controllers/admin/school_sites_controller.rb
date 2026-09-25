class Admin::SchoolSitesController < Admin::ApplicationController
  def index
    @school_sites = SchoolSite.order(:name)
  end

  def edit
    @school_site = SchoolSite.find(params[:id])
  end

  def create
    p = school_site_params
    if validate_params(p)
      SchoolSite.create!(p)
      flash[:notice] = "A school was added."
    end
    redirect_to admin_school_sites_path
  end

  def update
    p = school_site_params
    if validate_params(p)
      SchoolSite.find(params[:id]).update!(p)
      flash[:notice] = "A school was updated."
    end
    redirect_to admin_school_sites_path
  end

  def destroy
    school_site = SchoolSite.find(params[:id])
    if school_site.destroy
      flash[:notice] = "A school was deleted."
    else
      flash[:alert] = "The school could not be deleted because it is in use."
    end
    redirect_to admin_school_sites_path
  end

  private
  def school_site_params
    params.require(:school_site)
          .permit(:name, :address, :site_type, :latitude, :longitude,
                  :year_of_first_participation)
  end

  def validate_params(p)
    valid = false
    name = p[:name]
    addr = p[:address]
    year = p[:year_of_first_participation]
    if name == ""
      flash[:alert] = "School name is required."
    elsif addr == ""
      flash[:alert] = "School address is required."
    elsif not (year.match?(/\A\d{4}\z/) && (2020..Time.current.year).cover?(year.to_i))
      flash[:alert] = "YoFP must be a 4-digit integer between 2020 and the current year."
    else
      valid = true
    end
    valid
  end
end
