class Todo < ApplicationRecord
  belongs_to :project

  def self.load_template!(project)
    path = Rails.root.join(
      "config", "todo_templates", "default.yml"
    )
    items = YAML.safe_load(
      File.read(path), symbolize_names: true
    )
    items.each do |item|
      project.todos.create!(item)
    end
  end
end
