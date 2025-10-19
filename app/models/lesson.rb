class Lesson < ApplicationRecord
  belongs_to :school
  has_many :posts, dependent: :destroy
  has_many :rubrics, dependent: :destroy
end
