class AddSiteTypeToSchoolSites < ActiveRecord::Migration[8.0]
  def change
    add_column :school_sites, :site_type, :integer, null: false, default: 0
  end
end
