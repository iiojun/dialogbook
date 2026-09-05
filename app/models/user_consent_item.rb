class UserConsentItem < ApplicationRecord
  belongs_to :user_consent
  belongs_to :consent_item

  def agreed
    agreed_at.present?
  end

  def agreed=(value)
    self.agreed_at =
      ActiveModel::Type::Boolean.new.cast(value) ? Time.current : nil
  end
end
