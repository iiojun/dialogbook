class Mypage::ConsentFormVersionsController < ApplicationController
  def show
    @version = ConsentFormVersion.find(params[:id])
    @user_consent = @version.user_consents.find_by(user: current_user)
  end
end
