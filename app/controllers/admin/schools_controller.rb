class Admin::SchoolsController < Admin::ApplicationController
  def create
    p = school_params
    pj = Project.find(p[:pid])
    name = p[:name]
    addr = p[:address]
    memo = p[:memo]
    if name == ""
      flash[:alert] = "school name is required."
    elsif addr == ""
      flash[:alert] = "school address is required."
    else
      s = School.create(name: name, address: addr, memo: memo)
      pj.schools << s          # add to the project
      User.admins&.each { |a|  # add to admins
        a.schools << s
        us = UserSchool.find_by(user: a, school: s)
        us.registered = true
        us.save
      }
      flash[:notice] = "a school was added."
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

    # to conduct s.update(p) w/o errors, :pid has to be removed from the hash
    p = school_params.except(:pid)
    name = p[:name]
    addr = p[:address]
    memo = p[:memo]

    if name == ""
      flash[:alert] = "school name is required."
      redirect_to edit_admin_school_path(s)
    elsif addr == ""
      flash[:alert] = "school address is required."
      redirect_to edit_admin_school_path(s)
    else
      s.update(p)
      flash[:notice] = "a school was updated."
      redirect_to edit_admin_project_path(s.project)
    end
  end

  private
  def school_params
    params.require(:school).permit(:name, :address, :memo, :pid)
  end
end
