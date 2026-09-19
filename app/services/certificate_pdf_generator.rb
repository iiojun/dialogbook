class CertificatePdfGenerator
  TEMPLATE_PATH = Rails.root.join(
    "app", "assets", "pdfs", "certificate_template.pdf"
  )

  def initialize(certificate, design = nil)
    @certificate = certificate
    @design = design
  end

  def generate
    (@design) ? generate_from_design : generate_from_default
  end

  private
  def generate_from_design
    settings = @design.settings
    doc = HexaPDF::Document.new(io: StringIO.new(@design.background_pdf))
    page = doc.pages[0]
    canvas = page.canvas(type: :overlay)

    # Name
    name = @certificate.name
    name_settings = settings["name"]
    font_name = name_settings["font"]
    font_size = name_settings["size"]
    y = name_settings["y"]
    canvas.font(font_name, size: font_size, variant: :bold)
    text_width =
      canvas.font.decode_utf8(name).sum(&:width) * font_size / 1000.0
    # Name: centering
    page_width = page.box.width
    x = (page_width - text_width) / 2.0
    canvas.text(name, at: [x, y])

    # Date
    date_settings = settings["date"]
    canvas.font(date_settings["font"], size: date_settings["size"])
    canvas.text(I18n.l(@certificate.issued_at.to_date),
                at: [date_settings["x"], date_settings["y"]])

    # Number
    canvas.font("Helvetica", size: 14)
    canvas.text(@certificate.certificate_number, at: [580, 50])

    io = StringIO.new
    doc.write(io)
    io.string
  end

  def generate_from_default
    doc = HexaPDF::Document.open(TEMPLATE_PATH)
    page = doc.pages[0]
    canvas = page.canvas(type: :overlay)

    name = @certificate.name
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
    canvas.text(I18n.l(@certificate.issued_at.to_date), at: [455, 145])

    # Number
    canvas.font("Helvetica", size: 14)
    canvas.text(@certificate.certificate_number, at: [580, 50])

    io = StringIO.new
    doc.write(io)
    io.string
  end
end
