class Td::UsersController < Td::ApplicationController
  def index
    @users_app = User.joins(:schools) \
                   .where(schools: { id: current_user.school.id }) \
                   .where(user_schools: { registered: true })
    @users_req = User.joins(:schools) \
                   .where(schools: { id: current_user.school.id }) \
                   .where(user_schools: { registered: false })
  end

  def approve
    users_req = User.joins(:schools) \
                   .where(schools: { id: current_user.school.id }) \
                   .where(user_schools: { registered: false })
    users_req&.each { |u|
      UserSchool.where(user: u, registered: false)&.each { |us|
        us.register
      }
    }
    flash[:notice] = "All requests were approved."
    redirect_to td_users_path
  end

  def withdraw
    p = user_params
    begin
      u = User.find(p[:uid])
      s = School.find(p[:sid])
      us = UserSchool.find_by(user: u, school: s)
      us.unregister
      flash[:notice] = "User #{u.name}'s participation was withdrawn."
      redirect_to td_users_path
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "record not found."
      redirect_to td_users_path
    end
  end

  def delete
    p = user_params
    begin
      u = User.find(p[:uid])
      s = School.find(p[:sid])
      us = UserSchool.find_by(user: u, school: s)
      us.destroy
      flash[:notice] = "User #{u.name}'s request was deleted."
      redirect_to td_users_path
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "record not found."
      redirect_to td_users_path
    end
  end

  def edit
    p = user_params
    @user = User.find(p[:id])
  end

  def update
    p = user_params
    new_role = p[:role].to_s + (p[:admin] ? ",#{p[:admin]}" : '')
    user = User.find(p[:id])
    user.role = new_role
    # add all schools if the user is promoted to an administrator
    user.schools = School.all if user.is_admin?
    user.save
    for us in UserSchool.where(user: user)
      us.registered = true
      us.save
    end
    redirect_to td_users_path
  end

  private

  def user_params
    params.permit(:uid, :sid, :id, :admin, :role)
  end
end
