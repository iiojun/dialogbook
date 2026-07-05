class AddTimeZoneToSchools < ActiveRecord::Migration[8.0]
  def change
    add_column :schools, :time_zone, :string
  end
end
