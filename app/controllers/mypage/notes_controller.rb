class Mypage::NotesController < Mypage::ApplicationController
  def create
    p = note_params
    title   = p[:title]
    message = p[:message]
    url     = p[:url]
    meeting = Meeting.find(p[:mid])
    msg = null_check(title: title, message: message)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      n = Note.create(title: title, message: message, url: url)
      meeting.notes << n
      current_user.notes << n
      flash[:notice] = "The note was successfully added."
    end
    redirect_to mypage_user_path(current_user)
  end

  def destroy
    n = Note.find(params[:id])
    n.destroy
    flash[:notice] = "The note was successfully deleted."
    redirect_to mypage_user_path(current_user)
  end

  private

  def note_params
    params.require(:note).permit(:title, :message, :url, :mid)
  end
end
