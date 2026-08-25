class Mypage::SubmissionsController < Mypage::ApplicationController
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
                          time_zone: current_user.school.time_zone,
                          lesson: lesson, need_response: true)
    }

    flash[:notice] = "Scores and comments were successfully updated."
    redirect_to mypage_user_path(current_user)
  end

  private
  def submission_params
    {
      scores: score_params,
      posts: post_params
    }
  end

  def score_params
    params.fetch(:scores, {}).permit!
  end

  def post_params
    Array(params[:posts]).compact.map do |p|
      p.permit(:body, :lesson)
    end
  end
end
