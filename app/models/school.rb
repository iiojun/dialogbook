class School < ApplicationRecord
  belongs_to :project
  has_many :user_schools, dependent: :destroy
  has_many :users, through: :user_schools
  has_many :certificates, through: :user_schools
  has_many :lessons, dependent: :destroy

  validates :time_zone, presence: true

  after_create :set_code

  geocoded_by :address
  after_validation :geocode_and_update_time_zone, \
      if: :will_save_change_to_address?

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

  def determine_time_zone
    return "UTC" if latitude.blank? || longitude.blank?
    Array(WhereTZ.lookup(latitude, longitude)).uniq.first || "UTC"

    rescue StandardError => e
      Rails.logger.warn("Failed to determine time zone for School #{id}: #{e.message}")
  end

  def geocode_and_update_time_zone
    geocode
    self.time_zone = determine_time_zone
  end
end
