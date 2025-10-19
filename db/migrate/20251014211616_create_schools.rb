class CreateSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :schools do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.string :code
      t.text :memo

      t.timestamps
    end
  end
end
