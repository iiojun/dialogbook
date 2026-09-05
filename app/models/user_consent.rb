class UserConsent < ApplicationRecord
  belongs_to :user
  belongs_to :consent_form_version

  has_many :user_consent_items,
           dependent: :restrict_with_exception

  accepts_nested_attributes_for :user_consent_items

  scope :for_consent_form, ->(consent_form) {
    where(consent_form_version: consent_form.consent_form_versions)
  }
end
