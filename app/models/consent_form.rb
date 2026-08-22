class ConsentForm < ApplicationRecord
  belongs_to :project
  has_many :versions, class_name: "ConsentFormVersion",
                       dependent: :restrict_with_exception
end
