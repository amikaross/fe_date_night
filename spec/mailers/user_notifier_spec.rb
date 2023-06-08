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
end
