class Certificate < ApplicationRecord
  belongs_to :user_school

  enum :status, {
    pending: 0,
    issued: 1,
    revoked: 2
  }

  before_validation :set_uuid, on: :create
  before_validation :set_certificate_number, on: :create

  validates :uuid, presence: true, uniqueness: true
  validates :certificate_number, presence: true, uniqueness: true

  def certified?
    certificate.present?
  end

  def issue_certificate!
    create_certificate!(
      issued_at: Time.current,
      status: :issued
    )
  end

  private

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def set_certificate_number
    return if certificate_number.present?

    year = Time.current.year
    sequence = Certificate.count + 1

    self.certificate_number =
      format("SMILE-%d-%05d", year, sequence)
  end
end
