class Td::TodosController < Td::ApplicationController
  before_action :set_todo, only: [ :edit, :update, :destroy, :toggle ]
  def index
    @todos = Todo.where(project: current_user.school.project)
                 .order("created_at asc")
  end

  def create
    (title, memo, done) = set_parameters
    msg = null_check(title: title)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      t = Todo.create(title: title, memo: memo)
      current_user.school.project.todos << t
      flash[:notice] = "A new todo item was added."
    end
    redirect_to td_todos_path
  end

  def edit
  end

  def update
    (title, memo, done) = set_parameters
    msg = null_check(title: title)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
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
    @todo.update(
      done: params[:done]
    )
    head :ok
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :memo, :done)
  end

  def set_parameters
    p = todo_params
    [p[:title], p[:memo], p[:done]]
  end
end
