class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def show; end

  def new
    @ticket = Ticket.new
    @users = User.all.pluck(:name, :id)
  end

  def create; end

  def edit; end

  def update; end

  def destory; end
end
