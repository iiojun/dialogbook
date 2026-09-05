class ConsentItem < ApplicationRecord
  belongs_to :consent_form_version

  def agreed_by?(user_consent)
    user_consent.user_consent_items.find_by(consent_item: self)&.agreed
  end
end
