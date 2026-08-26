class UpdateConsentFormStructure < ActiveRecord::Migration[8.0]
  def change
    remove_column :consent_forms, :name, :string
    remove_column :consent_forms, :description, :text

    add_column :consent_form_versions, :title, :string
    add_column :consent_form_versions, :description, :text

    add_reference :consent_forms,
                  :current_version,
                  foreign_key: { to_table: :consent_form_versions }
  end
end
