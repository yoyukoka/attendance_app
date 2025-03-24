class UsersController < ApplicationController
  before_action :authenticate_user!

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
end
