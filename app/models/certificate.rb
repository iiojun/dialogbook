class Certificate < ApplicationRecord
  belongs_to :user_school

  enum :status, {
    pending: 0,
    issued: 1,
    revoked: 2
  }

  before_validation :set_uuid, on: :create
  after_create_commit :set_certificate_number!

  validates :uuid, presence: true, uniqueness: true

  private

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def set_certificate_number!
    return if certificate_number.present?

    number = format("SMILE-%d-%06d", Time.current.year, id)
    update_column(:certificate_number, number)
  end
end
