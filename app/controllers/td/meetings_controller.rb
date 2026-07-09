class Td::MeetingsController < Td::ApplicationController
  before_action :set_meeting, only: [ :edit, :update, :destroy ]

  def index
    @meetings = Meeting.where(project: current_user.school.project,
                              start_date: Time.now ...)
                       .order("start_date asc")
    @past_meetings = Meeting.where(project: current_user.school.project,
                              start_date: ... Time.now)
                       .order("start_date desc")
  end

  def create
    (name, memo, sdat) = set_parameters
    errors = [
      null_check(name: name),
      null_check(start_date: sdat)
    ].compact_blank
    if errors.any?
      flash[:alert] = "#{errors.join(', ')} must be filled."
      redirect_to new_td_meeting_path
      return
    end

    meeting = current_user.school.project.meetings.create!(
      name: name, memo: memo, start_date: sdat
    )
    flash[:notice] = "A new meeting was added."
    redirect_to td_meetings_path
  end

  def edit
  end

  def update
    (name, memo, sdat) = set_parameters
    errors = [
      null_check(name: name),
      null_check(start_date: sdat)
    ].compact_blank
    if errors.any?
      flash[:alert] = "#{errors.join(', ')} must be filled."
      redirect_to new_td_meeting_path
      return
    end

    @meeting.update!(name: name, memo: memo, start_date: sdat)
    flash[:notice] = "The meeting was successfully updated."
    redirect_to td_meetings_path
  end

  def destroy
    @meeting.destroy
    flash[:notice] = "The meeting was successfully deleted."
    redirect_to td_meetings_path
  end

  private
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:name, :memo, :start_date)
  end

  def set_parameters
    p = meeting_params
    name = p[:name]
    memo = p[:memo]
    sdat = p[:start_date]
    # converting local time to UTC
    if sdat.length > 0
      sdat = Time.use_zone(current_user.school.time_zone) do
        Time.zone.parse(sdat)
      end
    end
    [name, memo, sdat]
  end
end
