class Td::LessonsController < Td::ApplicationController
  before_action :set_lesson, only: [ :edit, :update, :destroy ]

  def index
    @lessons = Lesson.where(school: current_user.school)
                     .order("created_at asc")
    @rubrics = Rubric.where(lesson: @lessons)
  end

  def edit
    @rubrics = Rubric.where(lesson: @lesson)
  end

  def create
    title = set_parameters
    msg = null_check(title: title)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      l = Lesson.create(title: title)
      current_user.school.lessons << l
      flash[:notice] = "A new lesson was added."
    end
    redirect_to td_lessons_path
  end

  def update
    title = set_parameters
    msg = null_check(title: title)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      @lesson.title = title
      if @lesson.save
        flash[:notice] = "The lesson was successfully updated."
      else
        flash[:alert] = "Something went wrong."
      end
    end
    redirect_to td_lessons_path
  end

  def destroy
    @lesson.destroy
    flash[:notice] = "The lesson was successfully deleted."
    redirect_to td_lessons_path
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title)
  end

  def set_parameters
    p = lesson_params
    title = p[:title]
    title
  end
end
