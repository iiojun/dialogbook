class Td::CertificateDesignsController < ApplicationController
  def create
    design_params = certificate_design_params
    package = design_params[:package]
    name = design_params[:name]

    unless package.present? && name.present?
      redirect_to td_certificates_path,
                  alert: "Design name and package are required."
      return
    end

    begin
      Zip::File.open(package.tempfile.path) do |zip|
        background_entry = zip.find_entry("background.pdf")
        settings_entry = zip.find_entry("settings.json")
        raise "background.pdf not found" unless background_entry
        raise "settings.json not found" unless settings_entry

        background_pdf = background_entry.get_input_stream.read
        settings = JSON.parse(settings_entry.get_input_stream.read)

        CertificateDesign.transaction do
          current_user.school.certificate_designs
            .where(in_use: true).update_all(in_use: false)

          CertificateDesign.create!(
            school: current_user.school, name: params[:name],
            background_pdf: background_pdf, settings: settings,
            in_use: true
          )
        end
      end
      redirect_to td_certificates_path,
                  notice: "Certificate design uploaded and activated."

    rescue Zip::Error, JSON::ParserError, ActiveRecord::RecordInvalid => e
      redirect_to td_certificates_path,
                  alert: "Failed to upload certificate design: #{e.message}"
    rescue RuntimeError => e
      redirect_to td_certificates_path,
                  alert: e.message
    end
  end

  private
  def certificate_design_params
    params.require(:certificate_design).permit(:name, :package)
  end
end
