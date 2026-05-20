class Td::CertificatesController < ApplicationController
  def index
    @users = User.joins(:schools)
                 .where(schools: { id: current_user.school.id })
                 .where(user_schools: { registered: true })
                 .where(users: { role: "student" })
  end

  def create
    p = certificate_params
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

  def destroy
    p = certificate_params
    begin
      c = Certificate.find(p[:id])
      c.destroy
      flash[:notice] = "User #{c.user_school.user.name}'s certificate was revoked."
      redirect_to td_certificates_path
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "something wrong (record not found)."
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
    params.permit(:id, :uid, :sid)
  end
end
