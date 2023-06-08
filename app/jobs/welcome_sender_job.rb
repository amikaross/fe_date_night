class WelcomeSenderJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserNotifierMailer.welcome(user).deliver_now
  end
end
