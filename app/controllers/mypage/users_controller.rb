class Mypage::UsersController < Mypage::ApplicationController
  def show
    if current_user.name == nil
      redirect_to edit_mypage_user_path(current_user)
    else
      @school = @user.school
      @lessons = Lesson.where(school: @school)
      @meeting = Meeting.where(project: @school&.project,
                   start_date: (Time.now - 14400) ...) \
                     &.order("start_date asc").first
      # "Time.now - 14400" is a tentative patch
      # this allow us to remain showing the next meeting info
      # for 4 hours just after the meeting start time.
      @past_meetings = Meeting.where(project: @school&.project,
                   start_date: ... (Time.now - 14400)) \
                     &.order("start_date desc")

      # preparing user's comments for every lesson
      @posts = @user.prepare_posts

      @posts = (@user.is_teacher?) ?
        Post.joins(:user).where(users: {school: @school}, need_response: true)
            .order("updated_at desc") :
        Post.where(user: @user).order("updated_at desc")
      @comments = {}
      @posts&.each { |p|
        @comments[p] = Comment.where(post: p).order("created_at asc")
      }
      @scores = @user.prepare_scores&.order("created_at asc")
    end
  end

  def edit
  end

  def update
    p = user_params
    if p.include?(:code) and p[:code] != ""
      update_school(p)
    else
      if p[:name] == ""
        flash[:alert] = "user name is required."
        redirect_to edit_mypage_user_path(current_user)
      else
        p = p.except(:code) if p.include?(:code)
        p = p.except(:sid) if p.include?(:sid)
        current_user.update(p)
        flash[:notice] = "User's information was successfully updated."
        redirect_to edit_mypage_user_path(current_user)
      end
    end
  end

  def update_school(p)
    s = School.find_by(code: p[:code])
    if s == nil
      flash[:alert] = "school (code: #{p[:code]}) was not found."
    elsif current_user.schools.include?(s)
      flash[:alert] = "school (code: #{p[:code]}) has been already added."
    else
      current_user.schools << s
      # if the user is teacher, the school is automatically set active.
      if current_user.is_teacher?
        us = UserSchool.find_by(user: current_user, school: s)
        us.registered = true
        us.save
        # if the user is a teacher, set the new school as his/her school
        current_user.school = s
        current_user.save
      end
      flash[:notice] = "school (code: #{p[:code]}) was successfully added."
    end
    redirect_to edit_mypage_user_path(current_user)
  end

  def update_scores
    p = scores_params
    p.each { |key, value|
      id = value[:sid]
      s = Score.find(id)
      if s != nil
        s.level = value[:level]
        s.save
      end
    }
    update_posts
    flash[:notice] = "Scores and comments were successfully updated."
    redirect_to mypage_user_path(current_user)
  end

  def update_posts
    p = posts_params
    p.each { |key, msg|
      lesson = Lesson.find(msg[:lesson].to_i)
      post = Post.find_by(user: current_user, lesson: lesson)
      if post == nil
        Post.create(body: msg[:body],
          user: current_user, lesson: lesson,
          need_response: (msg[:body] != ""))
      else  
        # the case if the message was modified...
        if post.body != msg[:body]
          # first time the comment changed from initial status ("")
          if post.body == ""
            post.created_at = Time.now
          end
          post.body = msg[:body]
          post.need_response = true if msg[:body] != ""
          post.save
        end
      end
    }
  end

  def switch_school
    u = User.find(params[:id])
    s = School.find(params[:sid])
    u.school = s
    u.save
    flash[:notice] = "School was changed to #{s.name} (#{s.project.year})."
    redirect_to edit_mypage_user_path(u)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :picture, :sid, :code)
  end

  def scores_params
    params.require(:scores).permit!
  end

  def posts_params
    params.require(:posts).permit!
  end
end
