class Mypage::ConsentFormsController < Mypage::ApplicationController
  def show
    flash[:sticky] = nil
    @version = current_user.school&.project.consent_form&.published_version
    if @version.nil?
      redirect_to mypage_user_path(current_user)
      return
    end

    @user_consent = current_user.user_consents.build(
      consent_form_version: @version
    )

    @version.consent_items.each do |consent_item|
      @user_consent.user_consent_items.build(consent_item: consent_item)
    end
  end
end
