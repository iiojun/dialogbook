class Score < ApplicationRecord
  belongs_to :rubric
  belongs_to :user

  validates :rubric_id, uniqueness: { scope: :user_id }
end
