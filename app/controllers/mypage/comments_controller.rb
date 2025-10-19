class Mypage::CommentsController < Mypage::ApplicationController
  def create
    p = comment_params
    body = p[:body]
    msg = null_check(body: body)
    if (msg.length > 0)
      flash[:alert] = "#{msg} must be filled."
    else
      c = Comment.create(body: body)
      post = Post.find(p[:pid])
      post.comments << c
      current_user.comments << c
      post.need_response = !current_user.is_teacher?
      post.save
      flash[:notice] = "comment was successfully recorded."
    end
    redirect_to mypage_user_path(current_user)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :pid)
  end
end
