class Mypage::SubmissionsController < ApplicationController
  def update
    sp = submission_params

    # update scores
    scores = sp[:scores]
    scores.each { |key, value|
      id = value[:sid]
      s = Score.find(id)
      if s != nil
        s.level = value[:level]
        s.save
      end
    }

    # create posts
    posts = sp[:posts]
    posts.each { |p|
      next if p[:body] == ""
      lesson = Lesson.find(p[:lesson].to_i)
      post = Post.create!(body: p[:body], user: current_user,
                          lesson: lesson, need_response: true)
    }

    flash[:notice] = "Scores and comments were successfully updated."
    redirect_to mypage_user_path(current_user)
  end

  private
  def submission_params
    {
      scores: scores_params,
      posts: posts_params
    }
  end

  def scores_params
    params.fetch(:scores, {}).permit!
  end

  def posts_params
    Array(params[:posts]).compact.map do |p|
      p.permit(:body, :lesson)
    end
  end
end
