class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :user_signed_in?

  private

  def authenticate_user!
    redirect_to root_path unless session[:user_id]
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(uid: session[:user_id])
  end

  def user_signed_in?
    !!session[:user_id]
  end

  def null_check(hash)
    ary = hash&.map { |key, value| key.to_s if value == "" } - [nil]
    retval = "" if ary.length == 0
    retval = ary[0] if ary.length == 1
    retval = "#{ary[0]} and #{ary[1]}" if ary.length == 2
    if ary.length > 2
      lastword = ary.unshift
      retval = ary.join(", ") + ", and " + lastword
    end
    retval
  end
end
