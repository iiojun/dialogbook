class Admin::SchoolSitesController < Admin::ApplicationController
  def index
    @school_sites = SchoolSite.order(:name)
  end

  def create
    p = school_site_params
    name = p[:name]
    addr = p[:address]
    if name == ""
      flash[:alert] = "School name is required."
    elsif addr == ""
      flash[:alert] = "School address is required."
    else
      SchoolSite.create!(p)
      flash[:notice] = "A school was added."
    end
    redirect_to admin_school_sites_path
  end

  def edit
    @school_site = SchoolSite.find(params[:id])
  end

  def update
    s = SchoolSite.find(params[:id])
    p = school_site_params
    name = p[:name]
    addr = p[:address]
    if name == ""
      flash[:alert] = "School name is required."
    elsif addr == ""
      flash[:alert] = "School address is required."
    else
      s.update!(p)
      flash[:notice] = "A school was added."
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
          .permit(:name, :address, :type, :latitude, :longitude)
  end

end
