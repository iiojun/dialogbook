class CreateUserConsents < ActiveRecord::Migration[8.0]
  def change
    create_table :user_consents do |t|
      t.references :user, null: false, foreign_key: true
      t.references :consent_form_version, null: false, foreign_key: true
      t.string :status
      t.datetime :agreed_at
      t.datetime :revoked_at

      t.timestamps
    end
  end
end
