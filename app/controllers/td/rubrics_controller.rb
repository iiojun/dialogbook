class Td::RubricsController < Td::ApplicationController
  before_action :set_rubric, only: [ :edit, :update, :destroy ]

  def index
    school = current_user.school
    @lessons = Lesson.where(school: school).order("created_at asc")
    @rubrics = Rubric.where(lesson: @lessons)
    @students = User.where(school: school) \
                    .filter { |u| u.is_student? }

    respond_to do |format|
      format.html
      format.xlsx do
        response.headers["Content-Disposition"] =
            "attachment; filename=Scores_#{Date.today}.xlsx"
      end
    end
  end

  def create
    p = rubric_params
    item = p[:item]
    l = Lesson.find(p[:lid])
    msg = null_check(item: item)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      r = Rubric.create(item: item)
      l.rubrics << r
      flash[:notice] = "A new rubric item was added."
    end
    redirect_to edit_td_lesson_path(l.id)
  end

  def edit
  end

  def update
    p = rubric_params
    item = p[:item]
    msg = null_check(item: item)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      @rubric.item = item
      if @rubric.save
        flash[:notice] = "The rubric item was successfully updated."
      else
        flash[:alert] = "Something went wrong."
      end
    end
    redirect_to edit_td_lesson_path(@rubric.lesson.id)
  end

  def destroy
    l = @rubric.lesson
    @rubric.destroy
    flash[:notice] = "The rubric item was successfully deleted."
    redirect_to edit_td_lesson_path(l.id)
  end

  private

  def set_rubric
    @rubric = Rubric.find(params[:id])
  end

  def rubric_params
    params.require(:rubric).permit(:item, :lid)
  end
end
