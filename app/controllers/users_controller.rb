class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin, only: %i[admin_toggle destroy]

  def index
    @users = case params[:sort]
             when 'attendance_rate'
               User.all.sort_by(&:attendance_rate).reverse
             when 'user_id'
               User.order(:id) # ユーザーID順でソート
             else
               User.order_by_enum(:position, User.positions.keys)
             end
  end

  def show
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'ユーザーを削除しました。'
    else
      flash[:alert] = 'ユーザーの削除に失敗しました。'
    end
    redirect_to users_path
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
