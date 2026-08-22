class UserConsent < ApplicationRecord
  belongs_to :user
  belongs_to :consent_form_version

  has_many :user_consent_items,
           dependent: :restrict_with_exception
end
