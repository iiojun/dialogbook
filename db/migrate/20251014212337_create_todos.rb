class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.references :project, null: false, foreign_key: true
      t.text :title
      t.text :memo
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
