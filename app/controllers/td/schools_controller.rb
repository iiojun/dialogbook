class Td::SchoolsController < Td::ApplicationController
  def show
    @lessons = Lesson.joins(:school).where(school: params[:id])
    @posts = Post.where(lesson: @lessons).order('created_at desc')
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
    @comments = {}
    @posts&.each {|p|
      @comments[p] = Comment.where(post: p).order('created_at asc')
    }
  end
end
