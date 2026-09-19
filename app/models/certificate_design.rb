class CertificateDesign < ApplicationRecord
  belongs_to :school

  before_destroy :prevent_destroy_if_in_use

  def prevent_destroy_if_in_use
    throw(:abort) if in_use?
  end
end
