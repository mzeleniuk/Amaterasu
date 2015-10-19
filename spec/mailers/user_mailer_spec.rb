require 'rails_helper'

describe UserMailer, type: :mailer do
  describe '.account_activation' do
    let(:first_user) { User.create(first_name: 'Test', last_name: 'User', email: 'test@gmail.com',
                                   password: 'secret', password_confirmation: 'secret') }
    let(:mail) { UserMailer.account_activation(first_user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Amaterasu - Account activation')
      expect(mail.to).to eq([first_user.email])
      expect(mail.from).to eq(['noreply@amaterasu.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Hi, #{first_user.full_name}!")
      expect(mail.body.encoded).to match('Welcome to Amaterasu! Click on the link below to activate your account:')
    end
  end

  describe '.password_reset' do
    let(:last_user) { User.create(first_name: 'Test', last_name: 'Case', email: 'testing@gmail.com',
                                  password: 'secret', password_confirmation: 'secret', reset_token: 'Token') }
    let(:mail) { UserMailer.password_reset(last_user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Amaterasu - Password reset')
      expect(mail.to).to eq([last_user.email])
      expect(mail.from).to eq(['noreply@amaterasu.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('To reset your password click the link below:')
      expect(mail.body.encoded).to match('This link will expire in two hours.')
      expect(mail.body.encoded).to match('If you did not request your password to be reset, please ignore this email and your password will stay as it is.')
    end
  end

  describe '.welcome_email' do
    let(:last_user) { User.create(first_name: 'Welcome', last_name: 'Test', email: 'welcome@gmail.com',
                                  password: 'secret', password_confirmation: 'secret', reset_token: 'Token') }
    let(:mail) { UserMailer.welcome_email(last_user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to Amaterasu!')
      expect(mail.to).to eq([last_user.email])
      expect(mail.from).to eq(['noreply@amaterasu.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Welcome to Amaterasu!')
      expect(mail.body.encoded).to match('Thanks for joining Amaterasu!')
      expect(mail.body.encoded).to match('Now you can share your thoughts, follow other users, edit your account and do many other exciting things!')
      expect(mail.body.encoded).to match('Before start you\'ll want to fill your profile to tell others a bit more about yourself. You always can do it on the "Settings" page.')
    end
  end
end
