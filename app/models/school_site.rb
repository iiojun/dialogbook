class SchoolSite < ApplicationRecord
  has_many :schools, dependent: :restrict_with_error

  validates :time_zone, presence: true

  validates :year_of_first_participation,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2020,
              less_than_or_equal_to: Time.current.year
            },
            allow_blank: true

  geocoded_by :address
  before_validation :geocode_and_update_time_zone, \
      if: :will_save_change_to_address?

  enum :site_type, {
    university: 0,
    high_school: 1,
    junior_high_school: 2,
    elementary_school: 3,
    other: 4
  }

  def determine_time_zone
    return "UTC" if latitude.blank? || longitude.blank?
    Array(WhereTZ.lookup(latitude, longitude)).uniq.first || "UTC"

    rescue StandardError => e
      Rails.logger.warn("Failed to determine time zone for SchoolSite #{id}: #{e.message}")
  end

  def geocode_and_update_time_zone
    geocode
    self.time_zone = determine_time_zone
  end
end
