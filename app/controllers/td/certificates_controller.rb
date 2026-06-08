class Td::CertificatesController < ApplicationController
  def index
    @users = User.joins(:schools)
                 .where(schools: { id: current_user.school.id })
                 .where(user_schools: { registered: true })
                 .where(users: { role: "student" })
  end

  def create
    p = certificate_create_params
    begin
      user_school = UserSchool.find_by!(user: p[:uid], school: p[:sid])
      user_school.issue_certificate!
      flash[:notice] = "User #{user_school.user.name}'s certificate was issued."
      redirect_to td_certificates_path
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "something wrong (record not found)."
      redirect_to td_certificates_path
    end
  end

  def edit
    @cert = Certificate.find(params[:id])
  end

  def update
    begin
      c = Certificate.find(params[:id])
      c.update(certificate_params)
      flash[:notice] = "User #{c.name}'s certificate was updated."
      redirect_to td_certificates_path
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "something wrong (record not found)."
      redirect_to td_certificates_path
    end
  end

  def destroy
    begin
      c = Certificate.find(params[:id])
      c.destroy
      flash[:notice] = "User #{c.name}'s certificate was revoked."
      redirect_to td_certificates_path
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "something wrong (record not found)."
      redirect_to td_certificates_path
    end
  end

  def bulk_issue
    begin
      user_schools = UserSchool.joins(:user)
                               .where(users: { role: "student" })
                               .where(school: current_user.school)
                               .where.missing(:certificate)
                               .order(:user_id)
      if user_schools.length == 0
        flash[:alert] = "No need to issue new certificates."
      else
        user_schools.each { |us| us.issue_certificate! }
        flash[:notice] = "Certificates were issued."
      end
      redirect_to td_certificates_path
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "something wrong."
      redirect_to td_certificates_path
    end
  end

  def download_all
    certificates = current_user.school.certificates

    if certificates.length > 0
      send_data(
        pdf = BulkCertificatePdfGenerator.new(certificates).generate,
        filename: "certificates.pdf",
        type: "application/pdf",
        disposition: "attachment"
      )
    else
      flash[:alert] = "certificates not found."
      redirect_to td_certificates_path
    end
  end

  private

  def certificate_params
    params.require(:certificate).permit(:name)
  end

  def certificate_create_params
    params.permit(:id, :uid, :sid)
  end
end
