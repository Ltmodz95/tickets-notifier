# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit destroy update]
  before_action :set_users, only: %i[new create edit]
  def index
    @tickets = Ticket.includes(:assignee).all
  end

  def show; end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    return redirect_to @ticket if @ticket.save

    render :new, status: :unprocessable_entity
  end

  def edit; end

  def update
    @ticket.update(ticket_params)
    return redirect_to @ticket if @ticket.save

    render :new, status: :unprocessable_entityend
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :due_date, :user_id)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def set_users
    @users = User.all.pluck(:name, :id)
  end
end
