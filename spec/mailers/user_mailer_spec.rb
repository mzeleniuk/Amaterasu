require 'rails_helper'

describe UserMailer, type: :mailer do
  describe '.account_activation' do
    let(:first_user) { User.create(first_name: 'Test', last_name: 'User', email: 'test@gmail.com',
                                   password: 'secret', password_confirmation: 'secret') }
    let(:mail) { UserMailer.account_activation(first_user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Account activation')
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
      expect(mail.subject).to eq('Password reset')
      expect(mail.to).to eq([last_user.email])
      expect(mail.from).to eq(['noreply@amaterasu.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('To reset your password click the link below:')
      expect(mail.body.encoded).to match('This link will expire in two hours.')
      expect(mail.body.encoded).to match('If you did not request your password to be reset, please ignore this email and your password will stay as it is.')
    end
  end
end
