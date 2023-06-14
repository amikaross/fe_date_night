require "rails_helper"

RSpec.describe UserNotifierMailer, type: :mailer do
  describe 'welcome' do 
    before(:each) do 
      @user = User.create(email: 'lee@example.com', password: 'password')
      @mail = UserNotifierMailer.welcome(@user)
    end

    it 'renders the headers' do 
      expect(@mail.subject).to eq("Welcome to Date Night!")
      expect(@mail.to).to eq(["lee@example.com"])
      expect(@mail.from).to eq(["dateknight.info@gmail.com"])
    end

    it 'renders the body' do 
      expect(@mail.text_part.body.to_s).to include("Hi lee@example.com, we're so happy to have you.")
      expect(@mail.html_part.body.to_s).to include("Hi lee@example.com, we're so happy to have you.")
      expect(@mail.body.encoded.to_s).to include("Hi lee@example.com, we're so happy to have you.")
    end
  end

  describe 'invite' do 
    before(:each) do 
      @user = User.create(email: 'lee@example.com', password: 'password')
      @invitee = User.create(email: 'amanda@example.com', password: 'password')
      @mail = UserNotifierMailer.invite(@user.id, @invitee.id)
    end

    it 'renders the headers' do 
      expect(@mail.subject).to eq("You've Been Invited!")
      expect(@mail.to).to eq(["amanda@example.com"])
      expect(@mail.reply_to).to eq(['lee@example.com'])
    end

    it 'renders the body' do 
      expect(@mail.text_part.body.to_s).to include('Hello amanda@example.com!')
      expect(@mail.text_part.body.to_s).to include('lee@example.com has invited you on a date! Click here to accept their invitation.')
      expect(@mail.html_part.body.to_s).to include('Hello amanda@example.com!')
      expect(@mail.html_part.body.to_s).to include('lee@example.com has invited you on a date! Click here to accept their invitation.')
    end
  end
end
