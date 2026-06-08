class CertificatePdfGenerator
  TEMPLATE_PATH = Rails.root.join(
    "app", "assets", "pdfs", "certificate_template.pdf"
  )

  def initialize(certificate)
    @certificate = certificate
  end

  def generate
    doc = HexaPDF::Document.open(TEMPLATE_PATH)
    page = doc.pages[0]
    canvas = page.canvas(type: :overlay)

    name = @certificate.user_school.user.name
    font_name = "Helvetica"
    font_size = 36
    y = 280

    canvas.font(font_name, size: font_size, variant: :bold)
    # calculate the text width
    text_width =
      canvas.font.decode_utf8(name).sum(&:width) * font_size / 1000.0
    # Name: centering
    page_width = page.box.width
    x = (page_width - text_width) / 2.0
    canvas.text(name, at: [x, y])

    # Date
    canvas.font("Helvetica", size: 20)
    canvas.text(
      I18n.l(@certificate.issued_at.to_date),
      at: [455, 145]
    )
    # Number
    canvas.font("Helvetica", size: 14)
    canvas.text(
      @certificate.certificate_number,
      at: [580, 50]
    )

    io = StringIO.new
    doc.write(io)
    io.string
  end
end
