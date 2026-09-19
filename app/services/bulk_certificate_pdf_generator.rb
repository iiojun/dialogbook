class BulkCertificatePdfGenerator
  def initialize(certificates, school)
    @certificates = certificates
    @school = school
    @design = school.certificate_designs&.find_by(in_use: true)
  end

  def generate
    combined_pdf = CombinePDF.new

    @certificates.find_each do |certificate|
      pdf_binary =
        CertificatePdfGenerator
          .new(certificate, @design)
          .generate

      combined_pdf << CombinePDF.parse(pdf_binary)
    end

    combined_pdf.to_pdf
  end
end
