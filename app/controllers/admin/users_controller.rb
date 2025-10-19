class Admin::UsersController < Admin::ApplicationController
  def destroy
    u = User.find(params[:id])
    s = params[:sid]
    u.schools.delete(s)
    # the case the school is in use by the user.
    u.school = nil if u.school.id.to_s == s
    u.save
    flash[:notice] = "a user was removed from this class."
    redirect_to edit_admin_school_path(s)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    u = User.find(params[:id])
    p = user_params.except(:sid)
    p[:role] = p[:role] + ",admin" if u.is_admin?
    if p[:name] == ""
      flash[:alert] = "name is required."
      redirect_to edit_admin_user_path(u)
    else
      u.update(p)
      if u.is_teacher?
        UserSchool.where(user: u)&.each { |us|
          us.registered = true
          us.save
          u.school = us.school
        }
        u.save
      end
      flash[:notice] = "a user was updated."
      redirect_to edit_admin_school_path(u.school)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :picture,
                                 :role, :sid)
  end
end
