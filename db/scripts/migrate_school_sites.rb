# db/scripts/migrate_school_sites.rb

EARTH_RADIUS_M = 6_371_000
DISTANCE_THRESHOLD_M = 500

DRY_RUN = true

def distance_in_meters(lat1, lon1, lat2, lon2)
  lat1 = lat1.to_f * Math::PI / 180
  lon1 = lon1.to_f * Math::PI / 180
  lat2 = lat2.to_f * Math::PI / 180
  lon2 = lon2.to_f * Math::PI / 180

  dlat = lat2 - lat1
  dlon = lon2 - lon1

  a = Math.sin(dlat / 2)**2 +
      Math.cos(lat1) * Math.cos(lat2) * Math.sin(dlon / 2)**2

  2 * EARTH_RADIUS_M * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
end

# 既存のSchoolSiteを読み込む
school_sites = SchoolSite.all.to_a

School.find_each do |school|
  next if school.latitude.blank? || school.longitude.blank?

  # 500m以内で最も近いSchoolSiteを探す
  school_site = school_sites
    .select { |site| site.latitude.present? && site.longitude.present? }
    .min_by do |site|
      distance_in_meters(
        school.latitude,
        school.longitude,
        site.latitude,
        site.longitude
      )
    end

  distance = \
    if school_site
      distance_in_meters(school.latitude, school.longitude,
                         school_site.latitude, school_site.longitude)
    end

  if school_site && distance <= DISTANCE_THRESHOLD_M
    puts "School ##{school.id} #{school.name}"
    puts "  -> SchoolSite #{school_site.respond_to?(:id) ? "##{school_site.id}" : "(new)"}"
    puts "  distance: #{distance.round}m"
  else
    school_site = SchoolSite.new(
      name: school.name,
      address: school.address,
      latitude: school.latitude,
      longitude: school.longitude,
      time_zone: school.time_zone
    )

    school_sites << school_site

    puts "School ##{school.id} #{school.name}"
    puts "  -> NEW SchoolSite: #{school_site.name}"
  end

  next if DRY_RUN

  school_site.save! unless school_site.persisted?
  school.update!(school_site: school_site)

  puts "  School ##{school.id} -> SchoolSite ##{school_site.id}"
end
