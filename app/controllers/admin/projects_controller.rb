class Admin::ProjectsController < Admin::ApplicationController
  def index
    @projects = Project.all.order(year: :desc, name: :asc)
  end

  def create
    p = project_params
    name = p[:name]
    year = p[:year]
    memo = p[:memo]
    if name == ""
      flash[:alert] = "project name is required."
    elsif year == ""
      flash[:alert] = "project year is required."
    else
      Project.create(name: name, year: year, memo: memo)
      flash[:notice] = "a project was added."
    end
    redirect_to admin_root_path
  end

  def destroy
    begin
      Project.destroy(params[:id])
      flash[:notice] = "a project was deleted."
    rescue ActiveRecord::InvalidForeignKey
      flash[:alert] = "the project could not be deleted because it is in use."
    end
    redirect_to admin_root_path
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    pj = Project.find(params[:id])
    p = project_params
    name = p[:name]
    year = p[:year]
    memo = p[:memo]
    if name == ""
      flash[:alert] = "project name is required."
      redirect_to edit_admin_project_path(pj)
    elsif year == ""
      flash[:alert] = "project year is required."
      redirect_to edit_admin_project_path(pj)
    else
      pj.update(p)
      flash[:notice] = "a project was updated."
      redirect_to admin_root_path
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :year, :memo)
  end
end
