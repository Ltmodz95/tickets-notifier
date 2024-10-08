# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return redirect_to @user if @user.save

    render :new, status: :unprocessable_entity
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :send_due_date_reminder, :due_date_reminder_interval,
                                 :due_date_reminder_time, :time_zone)
  end

  def set_user
    @user = User.find(params[:id]) if params[:id]
  end
end
