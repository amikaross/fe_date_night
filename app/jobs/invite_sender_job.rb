class InviteSenderJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    UserNotifierMailer.invite(current_user, user_id).deliver_now
  end
end
