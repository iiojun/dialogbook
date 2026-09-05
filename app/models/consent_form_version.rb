class ConsentFormVersion < ApplicationRecord
  belongs_to :consent_form

  has_many :consent_items,
           -> { order(:position) },
           dependent: :restrict_with_exception
  has_many :user_consents,
           dependent: :restrict_with_exception

  def draft?
    status == "draft"
  end

  def published?
    status == "published"
  end

  def review_required?(user)
    !self.user_consents.exists?(user: user) ||
     self.user_consents.where(user: user).last.revoked_at.present?
  end
end
