class BulkCertificatePdfGenerator
  def initialize(certificates)
    @certificates = certificates
  end

  def generate
    combined_pdf = CombinePDF.new

    @certificates.find_each do |certificate|
      pdf_binary =
        CertificatePdfGenerator
          .new(certificate)
          .generate

      combined_pdf << CombinePDF.parse(pdf_binary)
    end

    combined_pdf.to_pdf
  end
end
