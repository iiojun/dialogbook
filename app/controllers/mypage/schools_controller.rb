class Mypage::SchoolsController < Mypage::ApplicationController
  def destroy
    s = School.find(params[:id])
    current_user.schools.delete(s)
    current_user.school = nil if current_user.school == s
    current_user.save
    flash[:notice] = "School info was successfully deleted."
    redirect_to edit_mypage_user_path(current_user)
  end
end
