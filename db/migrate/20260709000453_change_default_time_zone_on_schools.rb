class ChangeDefaultTimeZoneOnSchools < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
      UPDATE schools
      SET time_zone = 'UTC'
      WHERE time_zone IS NULL
    SQL

    change_column_default :schools, :time_zone, "UTC"
    change_column_null :schools, :time_zone, false
  end

  def down
    change_column_null :schools, :time_zone, true
    change_column_default :schools, :time_zone, nil
  end
end
