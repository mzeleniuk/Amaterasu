require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#profile_tooltip' do
    it 'returns a list with gender, date of birth, country, city, phone number and bio' do
      @user = create :user, gender: nil, date_of_birth: nil, country: nil, city: nil, phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('Gender (+5%)<br>Date of birth (+10%)<br>Country (+10%)<br>City (+10%)<br>Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with date of birth, country, city, phone number and bio' do
      @user = create :user, gender: 'Male', date_of_birth: nil, country: nil, city: nil, phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('Date of birth (+10%)<br>Country (+10%)<br>City (+10%)<br>Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with gender, country, city, phone number and bio' do
      @user = create :user, gender: nil, date_of_birth: Time.now - 20.years, country: nil, city: nil, phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('Gender (+5%)<br>Country (+10%)<br>City (+10%)<br>Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with gender, date of birth, city, phone number and bio' do
      @user = create :user, gender: nil, date_of_birth: nil, country: 'Ukraine', city: nil, phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('Gender (+5%)<br>Date of birth (+10%)<br>City (+10%)<br>Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with gender, date of birth, country, phone number and bio' do
      @user = create :user, gender: nil, date_of_birth: nil, country: nil, city: 'New York', phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('Gender (+5%)<br>Date of birth (+10%)<br>Country (+10%)<br>Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with gender, date of birth, country, city and bio' do
      @user = create :user, gender: nil, date_of_birth: nil, country: nil, city: nil, phone_number: '123456789', bio: nil

      expect(helper.profile_tooltip).to eq('Gender (+5%)<br>Date of birth (+10%)<br>Country (+10%)<br>City (+10%)<br>About me (+15%)')
    end

    it 'returns a list with gender, date of birth, country, city and phone number' do
      @user = create :user, gender: nil, date_of_birth: nil, country: nil, city: nil, phone_number: nil, bio: 'Admin.'

      expect(helper.profile_tooltip).to eq('Gender (+5%)<br>Date of birth (+10%)<br>Country (+10%)<br>City (+10%)<br>Phone number (+10%)')
    end

    it 'returns a list with country, city, phone number and bio' do
      @user = create :user, gender: 'Male', date_of_birth: Time.now - 22.years, country: nil, city: nil, phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('Country (+10%)<br>City (+10%)<br>Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with city, phone number and bio' do
      @user = create :user, gender: 'Male', date_of_birth: Time.now - 22.years, country: 'Ukraine', city: nil, phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('City (+10%)<br>Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with phone number and bio' do
      @user = create :user, gender: 'Male', date_of_birth: Time.now - 22.years, country: 'USA', city: 'Silent Hill', phone_number: nil, bio: nil

      expect(helper.profile_tooltip).to eq('Phone number (+10%)<br>About me (+15%)')
    end

    it 'returns a list with bio' do
      @user = create :user, gender: 'Male', date_of_birth: Time.now - 22.years, country: 'USA', city: 'Silent Hill', phone_number: '123456789', bio: nil

      expect(helper.profile_tooltip).to eq('About me (+15%)')
    end

    it 'returns "Profile completed" message' do
      @user = create :user, gender: 'Male', date_of_birth: Time.now - 22.years, country: 'USA', city: 'Silent Hill', phone_number: '123456789', bio: 'Test.'

      expect(helper.profile_tooltip).to eq(t('shared.personal_info.profile_completed'))
    end
  end
end
