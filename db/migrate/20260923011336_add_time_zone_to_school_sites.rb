class AddTimeZoneToSchoolSites < ActiveRecord::Migration[8.0]
  def change
    add_column :school_sites, :time_zone, :string
  end
end
