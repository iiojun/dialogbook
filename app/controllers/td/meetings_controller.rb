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
    msg = null_check(name: name)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      m = Meeting.create(name: name, memo: memo, start_date: sdat)
      current_user.school.project.meetings << m
      flash[:notice] = "A new meeting was added."
    end
    redirect_to td_meetings_path
  end

  def edit
  end

  def update
    (name, memo, sdat) = set_parameters
    msg = null_check(name: name)
    if msg.length > 0
      flash[:alert] = "#{msg} must be filled."
    else
      @meeting.name = name
      @meeting.memo = memo
      @meeting.start_date = sdat
      if @meeting.save
        flash[:notice] = "The meeting was successfully updated."
      else
        flash[:alert] = "Something went wrong."
      end
    end
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
    sdat = sprintf "%4d-%02d-%02d %02d:%02d:00",
        p["start_date(1i)"].to_i, p["start_date(2i)"].to_i,
        p["start_date(3i)"].to_i, p["start_date(4i)"].to_i,
        p["start_date(5i)"].to_i
    [name, memo, sdat]
  end
end
