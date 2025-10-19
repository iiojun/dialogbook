class CreateRubrics < ActiveRecord::Migration[8.0]
  def change
    create_table :rubrics do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :item

      t.timestamps
    end
  end
end
