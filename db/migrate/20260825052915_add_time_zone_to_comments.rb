class AddTimeZoneToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :time_zone, :string
  end
end
