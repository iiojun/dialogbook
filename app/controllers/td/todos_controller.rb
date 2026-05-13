class Td::TodosController < Td::ApplicationController
  before_action :set_todo, only: [ :edit, :update, :destroy, 
                                   :toggle ]
  def index
    @todos = Todo.where(project: current_user.school.project)
                 .order("position asc")
  end

  def create
    (position, title, memo, done) = set_parameters
    msg = null_check(title: title)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      current_user.school.project.todos
                  .create!(position: position, 
                           title: title, memo: memo)
      flash[:notice] = "A new todo item was added."
    end
    redirect_to td_todos_path
  end

  def edit
  end

  def update
    (position, title, memo, done) = set_parameters
    msg = null_check(position, title: title)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      @todo.position = position
      @todo.title = title
      @todo.memo = memo
      @todo.done = done
      if @todo.save
        flash[:notice] = "The todo item was successfully updated."
      else
        flash[:alert] = "Something went wrong."
      end
    end
    redirect_to td_todos_path
  end

  def destroy
    @todo.destroy
    flash[:notice] = "The todo item was successfully deleted."
    redirect_to td_todos_path
  end

  def toggle
    @todo.update(done: params[:done])
    head :ok
  end

  def load_default
    Todo.load_template!(current_user.school.project)
    redirect_to td_todos_path
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo)
          .permit(:position, :title, :memo, :done)
  end

  def set_parameters
    p = todo_params
    [p[:position].to_i, p[:title], p[:memo], p[:done]]
  end
end
