class CreateConsentForms < ActiveRecord::Migration[8.0]
  def change
    create_table :consent_forms do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
