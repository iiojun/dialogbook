class MakeTimeZoneNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :posts, :time_zone, false
    change_column_null :comments, :time_zone, false
  end
end
