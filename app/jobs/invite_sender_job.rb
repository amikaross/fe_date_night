class InviteSenderJob < ApplicationJob
  queue_as :default

  def perform(sender_id, user_id, appointment_id)
    UserNotifierMailer.invite(sender_id, user_id, appointment_id).deliver_now
  end
end
