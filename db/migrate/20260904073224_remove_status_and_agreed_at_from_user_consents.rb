class RemoveStatusAndAgreedAtFromUserConsents < ActiveRecord::Migration[8.0]
  def change
    remove_column :user_consents, :status, :string
    remove_column :user_consents, :agreed_at, :datetime
  end
end
