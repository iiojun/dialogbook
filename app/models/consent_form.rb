class ConsentForm < ApplicationRecord
  belongs_to :project
  belongs_to :current_version,
             class_name: "ConsentFormVersion",
             optional: true

  has_many :consent_form_versions,
           dependent: :restrict_with_exception
end
