class Mypage::UserConsentsController < Mypage::ApplicationController
  def create
    @version = current_user.school&.project.consent_form&.published_version
    if @version.nil?
      redirect_to mypage_user_path(current_user)
    else
      @user_consent = current_user.user_consents.build(
        consent_form_version: @version
      )
      if @user_consent.update(user_consent_params)
        flash[:notice] = "Your consent has been recorded."
        redirect_to mypage_user_path(current_user)
      else
        render "mypage/consent_forms/show", status: :unprocessable_entity
      end
    end
  end

  def update
    uc = UserConsent.find(params[:ucid])
    uc.update!(revoked_at: Time.now)
    flash[:notice] = "A consent form was revoked."
    redirect_to mypage_user_path(current_user)
  end

  def user_consent_params
    params.require(:user_consent).permit(
      user_consent_items_attributes: [:consent_item_id, :agreed])
end
end
