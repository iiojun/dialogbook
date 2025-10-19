class UserSchool < ApplicationRecord
  belongs_to :user
  belongs_to :school

  before_destroy :remove_user_school

  def remove_user_school
    u = self.user
    s = self.school
    if u.school == s
      u.school = nil
      u.save
    end
  end

  def register
    self.registered = true
    self.save
    u = self.user
    u.school = self.school
    u.save
  end

  def unregister
    self.registered = false
    self.save
    remove_user_school
  end
end
