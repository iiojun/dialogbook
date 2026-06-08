class AddNameToCertificate < ActiveRecord::Migration[8.0]
  def change
    add_column :certificates, :name, :string
  end
end
