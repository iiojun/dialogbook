class CreateUserSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :user_schools do |t|
      t.references :user, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.boolean :registered, null: false, default: false

      t.timestamps
    end
  end
end
