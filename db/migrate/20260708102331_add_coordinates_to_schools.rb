class AddCoordinatesToSchools < ActiveRecord::Migration[8.0]
  def change
    add_column :schools, :latitude, :decimal, precision: 10, scale: 7
    add_column :schools, :longitude, :decimal, precision: 10, scale: 7
  end
end
