class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :check_admin, only: %i[new create edit update destroy]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all.order(date: :asc)
  end

  def show
    @attendance = @event.attendances.find_by(user: current_user)
    @positions_count = @event.attendances.joins(:user).group('users.position').count
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'イベントが作成されました。'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'イベントが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'イベントが削除されました。'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :date, :details)
  end

  def check_admin
    redirect_to root_path, alert: '権限がありません' unless current_user&.is_admin?
  end
end
