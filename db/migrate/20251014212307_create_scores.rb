class CreateScores < ActiveRecord::Migration[8.0]
  def change
    create_table :scores do |t|
      t.references :rubric, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
