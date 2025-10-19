class Rubric < ApplicationRecord
  belongs_to :lesson
  has_many :scores, dependent: :destroy
end
