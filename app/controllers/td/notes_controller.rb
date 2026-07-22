class Td::NotesController < Td::ApplicationController
  def edit
    @note = Note.find(params[:id])
  end

  def update
    note = Note.find(params[:id])
    p = note_params
    title   = p[:title]
    message = p[:message]
    msg = null_check(title: title, message: message)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      if note.update(p.except(:mid))
        flash[:notice] = "The note was successfully updated."
      else
        flash[:alert] = "Something went wrong."
      end
    end
    redirect_to edit_td_meeting_path(meeting)
  end

  def destroy
    note = Note.find(params[:id])
    meeting = note.meeting
    note.destroy
    flash[:notice] = "The note was successfully deleted."
    redirect_to edit_td_meeting_path(meeting)
  end

  private

  def note_params
    params.require(:note).permit(:title, :message, :url, :mid, :done)
  end
end
