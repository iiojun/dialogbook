class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :year
      t.text :memo

      t.timestamps
    end
  end
end
