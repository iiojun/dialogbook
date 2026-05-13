class AddPositionToTodo < ActiveRecord::Migration[8.0]
  def change
    add_column :todos, :position, :integer
  end
end
