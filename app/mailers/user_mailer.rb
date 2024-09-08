class UserMailer < ApplicationMailer
  default from: 'remainder@planrada.com'
  def due_date_reminder
    @ticket = Ticket.find(params[:ticket_id])
    @assignee = @ticket.assignee

    mail(to: @assignee.email, subject: "Ticket ##{@ticket.id} due date reminder")
  end
end
