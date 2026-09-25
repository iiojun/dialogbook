class MakeSchoolSiteIdNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :schools, :school_site_id, false
  end
end
