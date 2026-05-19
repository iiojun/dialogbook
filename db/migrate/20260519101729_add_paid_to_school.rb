class AddPaidToSchool < ActiveRecord::Migration[8.0]
  def change
    add_column :schools, :paid, :boolean, default: false
  end
end
