# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'remainder@planrada.com'
  after_action :mark_reminder_sent
  before_action :set_email_data

  def due_date_reminder
    mail(to: @assignee.email, subject: "Ticket ##{@ticket.id} due date reminder")
  end

  private

  def mark_reminder_sent
    @ticket.update(reminder_sent: true)
  end

  def set_email_data
    @ticket = Ticket.find(params[:ticket_id])
    @assignee = @ticket.assignee
  end
end
