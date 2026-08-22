class CreateConsentItems < ActiveRecord::Migration[8.0]
  def change
    create_table :consent_items do |t|
      t.references :consent_form_version, null: false, foreign_key: true
      t.string :code
      t.string :title
      t.text :description
      t.boolean :required
      t.integer :position

      t.timestamps
    end
  end
end
