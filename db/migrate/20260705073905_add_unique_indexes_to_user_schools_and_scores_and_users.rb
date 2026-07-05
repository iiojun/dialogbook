class AddUniqueIndexesToUserSchoolsAndScoresAndUsers < ActiveRecord::Migration[8.0]
  def change
    add_index :user_schools, [:user_id, :school_id], unique: true
    add_index :scores, [:rubric_id, :user_id], unique: true
    add_index :users, [:provider, :uid], unique: true
  end
end
