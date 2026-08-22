class UserConsentItem < ApplicationRecord
  belongs_to :user_consent
  belongs_to :consent_item
end
