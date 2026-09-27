class Admin::SchoolsController < Admin::ApplicationController
  def create
    p = school_params
    if validate_params(p)
      s = School.create(p)
      User.admins&.each { |a|  # add to admins
        a.schools << s
        us = UserSchool.find_by(user: a, school: s)
        us.registered = true
        us.save
      }
      flash[:notice] = "A class was added."
    end
    redirect_to edit_admin_project_path(s.project)
  end

  def update
    s = School.find(params[:id])
    p = school_params
    if validate_params(p)
      s.update(p)
      flash[:notice] = "A class was updated."
      redirect_to edit_admin_project_path(s.project)
    end
  end

  def edit
    @school = School.find(params[:id])
  end

  def destroy
    begin
      pj = School.find(params[:id]).project
      School.destroy(params[:id])
      flash[:notice] = "A school was deleted."
    rescue ActiveRecord::InvalidForeignKey
      flash[:alert] = "The project could not be deleted because it is in use."
    end
    redirect_to edit_admin_project_path(pj)
  end

  private
  def school_params
    params.require(:school).permit(:name, :memo, :paid,
                                   :school_site_id, :project_id)
  end

  def validate_params(p)
    valid = false
    name = p[:name]
    site = p[:school_site_id]
    if name == ""
      flash[:alert] = "Class name is required."
    elsif site == ""
      flash[:alert] = "School is required."
    else
      valid = true
    end
    valid
  end
end
