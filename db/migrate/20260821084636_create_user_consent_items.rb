class CreateUserConsentItems < ActiveRecord::Migration[8.0]
  def change
    create_table :user_consent_items do |t|
      t.references :user_consent, null: false, foreign_key: true
      t.references :consent_item, null: false, foreign_key: true
      t.datetime :agreed_at

      t.timestamps
    end
  end
end
