class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin, only: [:admin_toggle]

  def index
    @users = case params[:sort]
             when 'position'
               User.order_by_enum(:position, User.positions.keys)
             when 'attendance_rate'
               User.all.sort_by(&:attendance_rate).reverse
             else
               User.all
             end
  end

  def show
    @user = current_user
  end

  def admin_toggle
    @user = User.find(params[:id])
    if @user.update(is_admin: params[:user][:is_admin])
      flash[:notice] = '管理者権限を更新しました。'
    else
      flash[:alert] = '管理者権限の更新に失敗しました。'
    end
    redirect_to users_path
  end

  private

  def ensure_admin
    redirect_to root_path, alert: '権限がありません。' unless current_user.is_admin
  end
end
