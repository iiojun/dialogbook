class Meeting < ApplicationRecord
  belongs_to :project
  has_many :notes, dependent: :destroy

  scope :visible_to_students, -> { where(teacher_only: false) }
  scope :teacher_only,        -> { where(teacher_only: true) }
  scope :visible_to, ->(user) {
    if user.is_teacher?
      all
    else
      where(teacher_only: false)
    end
  }
end
