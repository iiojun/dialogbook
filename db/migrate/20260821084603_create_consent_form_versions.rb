class CreateConsentFormVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :consent_form_versions do |t|
      t.references :consent_form, null: false, foreign_key: true
      t.integer :version
      t.string :status
      t.datetime :published_at

      t.timestamps
    end
  end
end
