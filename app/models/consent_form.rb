class ConsentForm < ApplicationRecord
  belongs_to :project
  belongs_to :current_version,
             class_name: "ConsentFormVersion",
             optional: true

  has_many :consent_form_versions,
           dependent: :restrict_with_exception

  def load_template!
    path = Rails.root.join(
      "config", "consent_form_templates", "default.yml"
    )
    config = YAML.load_file(path)
    version = consent_form_versions.create!(
      config["consent_form_version"]
    )
    config["consent_items"].each do |item|
      version.consent_items.create!(item)
    end
    self.current_version = version
    save!
  end

  def create_new_version!
    old_version = current_version

    transaction do
      new_version = consent_form_versions.create!(
        title: old_version.title,
        description: old_version.description,
        version: old_version.version + 1,
        status: :draft
      )

      old_version.consent_items.find_each do |item|
        new_version.consent_items.create!(
          position: item.position,
          title: item.title,
          description: item.description,
        )
      end

      update!(current_version: new_version)

      new_version
    end
  end

  def published_version
    consent_form_versions
      .where.not(published_at: nil).order(published_at: :desc).first
  end

  def versions(user)
    consent_form_versions.joins(:user_consents)
                         .where(user_consents: { user_id: user.id })
  end
end
