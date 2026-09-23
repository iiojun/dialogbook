class AddSchoolSiteToSchools < ActiveRecord::Migration[8.0]
  def change
    add_reference :schools, :school_site, null: true, foreign_key: true
  end
end
