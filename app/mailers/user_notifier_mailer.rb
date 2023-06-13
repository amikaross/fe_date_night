class UserNotifierMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail(
      to: @user.email,
      subject: "Welcome to Date Night!"
    )
  end

  def invite(sender, user_id)
    @user = User.find_by(id: user_id)
    @sender = sender

    mail(
      to: @user.email,
      subject: "You've Been Invited!",
      reply_to: @sender.email
    )
  end
end
