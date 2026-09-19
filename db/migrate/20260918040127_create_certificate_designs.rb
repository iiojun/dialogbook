class CreateCertificateDesigns < ActiveRecord::Migration[8.0]
  def change
    create_table :certificate_designs do |t|
      t.references :school, null: false, foreign_key: true, index: false
      t.string :name
      t.binary :background_pdf
      t.jsonb :settings
      t.boolean :in_use, null: false, default: false

      t.timestamps
    end

    add_index :certificate_designs,
              :school_id,
              unique: true,
              where: "in_use = TRUE"
  end
end
