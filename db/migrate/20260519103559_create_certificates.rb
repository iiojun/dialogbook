class CreateCertificates < ActiveRecord::Migration[8.0]
  def change
    create_table :certificates do |t|
      t.references :user_school, null: false, foreign_key: true
      t.datetime :issued_at
      t.string :certificate_number
      t.string :uuid, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end

    add_index :certificates, :uuid, unique: true
    add_index :certificates, :certificate_number, unique: true
  end
end
