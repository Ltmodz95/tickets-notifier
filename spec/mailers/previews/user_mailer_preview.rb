# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def due_date_reminder
    UserMailer.with(ticket_id: Ticket.first.id).due_date_reminder
  end
end
