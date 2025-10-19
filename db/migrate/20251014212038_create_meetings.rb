class CreateMeetings < ActiveRecord::Migration[8.0]
  def change
    create_table :meetings do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.datetime :start_date
      t.text :memo

      t.timestamps
    end
  end
end
