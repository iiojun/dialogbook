class AddYearOfFirstParticipationToSchoolSites < ActiveRecord::Migration[8.0]
  def change
    add_column :school_sites, :year_of_first_participation, :integer
  end
end
