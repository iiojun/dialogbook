class HomeController < ApplicationController
  def index
    if current_user
      redirect_to mypage_user_path(current_user)
    end
  end
end
