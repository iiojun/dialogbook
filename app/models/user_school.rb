class UserSchool < ApplicationRecord
  belongs_to :user
  belongs_to :school
  has_one :certificate, dependent: :destroy

  before_destroy :remove_user_school

  delegate :issued?, to: :certificate, allow_nil: true

  validates :user_id, uniqueness: { scope: :school_id }

  def remove_user_school
    u = self.user
    s = self.school
    if u.school == s
      u.school = nil
      u.save
    end
  end

  def register
    self.registered = true
    self.save
    u = self.user
    u.school = self.school
    u.save
  end

  def unregister
    self.registered = false
    self.save
    remove_user_school
  end

  def certified?
    certificate.present?
  end

  def issue_certificate!
    return certificate if certified?

    create_certificate!(
      name: self.user.name,
      issued_at: Time.current,
      status: :issued
    )
  end
end
