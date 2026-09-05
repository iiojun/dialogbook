class Td::ConsentFormVersionsController < Td::ApplicationController
  def create
    p = consent_form_version_params
    title = p[:title]
    description = p[:description]
    msg = null_check(title: title, description: description)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      p[:version] = 1 if p[:version] == ""
      p[:status] = :draft if p[:status] == ""
      project = current_user.school.project
      project.consent_form = ConsentForm.create!(project: project)
      p[:consent_form] = project.consent_form
      project.consent_form.current_version = ConsentFormVersion.create!(p)
      project.consent_form.save!
      flash[:notice] = "A new consent form was added."
    end
    redirect_to td_consent_forms_path
  end

  def update
    p = consent_form_version_params
    title = p[:title]
    description = p[:description]
    msg = null_check(title: title, description: description)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      project = current_user.school.project
      if project.consent_form.current_version.published?
        flash[:alert] = "published version cannot be modified."
      else
        project.consent_form.current_version.update!(p)
        flash[:notice] = "The draft of consent form was updated."
      end
    end
    redirect_to td_consent_forms_path
  end

  def publish
    consent = current_user.school.project.consent_form.current_version
    consent.status = :published
    consent.published_at = Time.now
    consent.save!
    flash[:notice] = "The consent form was published."
    redirect_to td_consent_forms_path
  end

  private
  def consent_form_version_params
    params.require("consent_form_version")
          .permit(:title, :description, :version, :status)
  end
end
