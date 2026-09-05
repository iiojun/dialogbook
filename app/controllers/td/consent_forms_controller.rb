class Td::ConsentFormsController < Td::ApplicationController
  def index
    @consent = current_user.school.project.consent_form
    @students = current_user.school.users.where(role: "student")
    @published_version = @consent.published_version
  end

  def load_default
    project = current_user.school.project
    if project.consent_form.nil?
      consent_form = ConsentForm.create!(project: project)
      current_user.school.project.consent_form = consent_form
      consent_form.load_template!
    else
      flash[:alert] = "A Consent Form already exists."
    end
    redirect_to td_consent_forms_path

  end

  def new_version
    consent_form = current_user.school.project.consent_form
    if consent_form.current_version.published?
      consent_form.create_new_version!
      flash[:notice] = "A new consent form was ready."
    end
    redirect_to td_consent_forms_path
  end

  def user_review
  end

  def user_consent
  end
end
