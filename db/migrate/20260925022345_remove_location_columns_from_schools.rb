class RemoveLocationColumnsFromSchools < ActiveRecord::Migration[8.0]
  def change
    remove_column :schools, :address, :string
    remove_column :schools, :latitude, :float
    remove_column :schools, :longitude, :float
    remove_column :schools, :time_zone, :string
  end
end
