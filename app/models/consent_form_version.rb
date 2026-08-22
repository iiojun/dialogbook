class ConsentFormVersion < ApplicationRecord
  belongs_to :consent_form

  has_many :consent_items,
           -> { order(:position) },
           dependent: :restrict_with_exception

  has_many :user_consents,
           dependent: :restrict_with_exception
end
