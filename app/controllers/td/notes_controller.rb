class Td::NotesController < Td::ApplicationController
  def edit
    @note = Note.find(params[:id])
  end

  def update
    p = note_params
    title   = p[:title]
    message = p[:message]
    url     = p[:url]
    meeting = p[:meeting]
    msg = null_check(title: title, message: message)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      if note.update(p)
        flash[:notice] = "The note was successfully updated."
      else
        flash[:alert] = "Something went wrong."
      end
    end
    redirect_to edit_td_lesson_path(meeting)
  end

  def destroy
    n = Note.find(params[:id])
    meeting = n.meeting
    n.destroy
    flash[:notice] = "The note was successfully deleted."
    redirect_to edit_td_meeting_path(meeting)
  end

  private

  def note_params
    params.require(:note).permit(:title, :message, :url, :mid)
  end
end
