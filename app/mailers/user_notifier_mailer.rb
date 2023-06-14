class UserNotifierMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail(
      to: @user.email,
      subject: "Welcome to Date Night!"
    )
  end

  def invite(sender_id, user_id, appointment_id)
    @user = User.find_by(id: user_id)
    @sender = User.find_by(id: sender_id)
    @appointment_id = appointment_id

    mail(
      to: @user.email,
      subject: "You've Been Invited!",
      reply_to: @sender.email
    )
  end
end
