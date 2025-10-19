class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin

  def authenticate_admin
    redirect_to "/", alert: "Not authorized." \
        unless current_user && current_user.is_admin?
  end
end
