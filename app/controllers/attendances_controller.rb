class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.find_or_initialize_by(user: current_user)
    if @attendance.update(status: params[:status])
      redirect_to @event, notice: '出席状況を更新しました。'
    else
      redirect_to @event, alert: '更新に失敗しました。'
    end
  end
end
