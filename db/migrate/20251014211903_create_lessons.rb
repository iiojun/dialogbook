class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :school, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
