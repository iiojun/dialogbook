class Td::ApplicationController < ApplicationController
  before_action :only_teachers_can_access!

  private
  # only teachers (and admins) can access
  def only_teachers_can_access!
    redirect_to mypage_user_path(current_user) \
      unless current_user.is_teacher? or current_user.is_admin?
  end
end
