class AddTimeZoneToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :time_zone, :string
  end
end
