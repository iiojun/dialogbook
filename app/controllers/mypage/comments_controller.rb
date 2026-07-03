class Mypage::CommentsController < Mypage::ApplicationController
  def create
    p = comment_params
    body = p[:body].to_s.strip
    @post = Post.find(p[:pid])
    msg = null_check(body: body)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      Comment.create!(body: body, post: @post, user: current_user)
      @post.record_response_from!(current_user)
      flash[:notice] = "comment was successfully recorded."
    end
    redirect_to p[:return_to].presence || mypage_user_path(current_user)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :pid, :return_to)
  end
end
