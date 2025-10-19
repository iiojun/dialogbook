class School < ApplicationRecord
  belongs_to :project
  has_many :user_schools, dependent: :destroy
  has_many :users, through: :user_schools
  has_many :lessons, dependent: :destroy

  after_create :set_code

  def set_code
    update_column(:code, short_hash_base62(self.id.to_s))
  end

  private

  require "digest"
  CHARS = [*"0".."9", *"A".."Z", *"a".."z"]

  def short_hash_base62(input)
    num = Digest::SHA256.hexdigest(input).to_i(16)
    s = ""
    6.times do
      s << CHARS[num % 62]
      num /= 62
    end
    s.reverse
  end
end
