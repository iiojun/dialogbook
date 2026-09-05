class Project < ApplicationRecord
  has_many :schools, dependent: :destroy
  has_many :meetings, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_one :consent_form, dependent: :destroy
end
