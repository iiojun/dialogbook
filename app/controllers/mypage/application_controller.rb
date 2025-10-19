class Mypage::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :only_my_page_can_be_accessible!

  private

  # only my-own-page can be accessible
  def only_my_page_can_be_accessible!
    @user = (params.has_key?(:id)) ? User.find(params[:id]) : current_user
    redirect_to mypage_user_path(current_user) \
      if !current_user.is_admin? && @user != current_user
  end
end
