class Admin::SchoolsController < Admin::ApplicationController
  def create
    p = school_params
    pj = Project.find(p[:project_id])
    name = p[:name]
    addr = p[:address]
    if name == ""
      flash[:alert] = "Class name is required."
    elsif addr == ""
      flash[:alert] = "Class address is required."
    else
      s = School.create(p.except(:project_id))
      pj.schools << s          # add to the project
      User.admins&.each { |a|  # add to admins
        a.schools << s
        us = UserSchool.find_by(user: a, school: s)
        us.registered = true
        us.save
      }
      flash[:notice] = "A class was added."
    end
    redirect_to edit_admin_project_path(pj)
  end

  def destroy
    begin
      pj = School.find(params[:id]).project
      School.destroy(params[:id])
      flash[:notice] = "a school was deleted."
    rescue ActiveRecord::InvalidForeignKey
      flash[:alert] = "the project could not be deleted because it is in use."
    end
    redirect_to edit_admin_project_path(pj)
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    s = School.find(params[:id])

    # to conduct s.update(p) w/o errors, :project_id has to be removed from the hash
    p = school_params.except(:project_id)
    name = p[:name]
    addr = p[:address]
    memo = p[:memo]
    paid = p[:paid]

    if name == ""
      flash[:alert] = "Class name is required."
      redirect_to edit_admin_school_path(s)
    elsif addr == ""
      flash[:alert] = "Class address is required."
      redirect_to edit_admin_school_path(s)
    else
      s.update(p)
      flash[:notice] = "a school was updated."
      redirect_to edit_admin_project_path(s.project)
    end
  end

  private
  def school_params
    params.require(:school).permit(:name, :memo, :paid,
                                   :school_site_id, :project_id)
  end
end
