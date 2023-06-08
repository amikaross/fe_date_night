class UserNotifierMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail(
      to: @user.email,
      subject: "Welcome to Date Night!"
    )
  end
end
