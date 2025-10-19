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


  private

  def user_params
    params.permit(:uid, :sid)
  end
end
