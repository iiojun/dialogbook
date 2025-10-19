class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :name
      t.string :role, null: false, default: "student"
      t.string :nickname
      t.string :picture
      t.references :school, null: true, foreign_key: true

      t.timestamps
    end
  end
end
