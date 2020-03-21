require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create :user
  end

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:gender) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:country) }
  it { should respond_to(:city) }
  it { should respond_to(:address) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:bio) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:remember) }
  it { should respond_to(:forget) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:activate) }
  it { should respond_to(:send_activation_email) }
  it { should respond_to(:create_reset_digest) }
  it { should respond_to(:send_password_reset_email) }
  it { should respond_to(:password_reset_expired?) }
  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }
  it { should respond_to(:active_relationships) }
  it { should respond_to(:following) }
  it { should respond_to(:passive_relationships) }
  it { should respond_to(:followers) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow) }
  it { should respond_to(:unfollow) }

  it { should be_valid }
  it { should_not be_admin }

  describe 'with admin attribute set to true' do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe 'when first name is not present' do
    before { @user.first_name = ' ' }

    it { should_not be_valid }
  end

  describe 'when last name is not present' do
    before { @user.last_name = ' ' }

    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = ' ' }

    it { should_not be_valid }
  end

  describe 'when first name is too long' do
    before { @user.first_name = 'a' * 51 }

    it { should_not be_valid }
  end

  describe 'when last name is too long' do
    before { @user.last_name = 'a' * 51 }

    it { should_not be_valid }
  end

  describe 'when gender is incorrect' do
    before { @user.gender = 'Wrong' }

    it { should_not be_valid }
  end

  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address

        expect(@user).not_to be_valid
      end
    end
  end

  describe 'when email is too long' do
    it 'should be invalid' do
      @user.email = 'a' * 50 + '@mail.com'

      expect(@user).not_to be_valid
    end
  end

  describe 'when email format is valid' do
    it 'should be valid' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address

        expect(@user).to be_valid
      end
    end
  end

  describe 'when email address is already taken' do
    it 'does not valid' do
      temp_user = build :user, email: @user.email
      temp_user.save

      expect(temp_user.valid?).to eq(false)
      expect(temp_user.errors[:email]).to eq(['has already been taken'])
    end
  end

  describe 'when password is not present' do
    before { @user.password = @user.password_confirmation = '' }

    it { should_not be_valid }
  end

  describe 'when password does not match confirmation' do
    before { @user.password_confirmation = 'mismatch' }

    it { should_not be_valid }
  end

  describe 'with a password that is too short' do
    before { @user.password = @user.password_confirmation = 'a' * 5 }

    it { should be_invalid }
  end

  describe 'return value of authenticate method' do
    before { @user.save }

    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe 'email address with mixed case' do
    let(:mixed_case_email) { 'Foo@ExAMPle.CoM' }

    it 'should be saved as all lower-case' do
      @user.email = mixed_case_email
      @user.save

      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe 'Phone number' do
    it 'is invalid when phone_number is not a number' do
      user = build :user, phone_number: 'invalid'

      expect(user.valid?).to eq(false)
      expect(user.errors[:phone_number]).to eq(['is not a number'])
    end

    it 'is invalid when phone_number is too long' do
      user = build :user, phone_number: '1' * 25

      expect(user.valid?).to eq(false)
      expect(user.errors[:phone_number]).to eq(['is too long (maximum is 20 characters)'])
    end
  end

  describe 'Country' do
    it 'is invalid when country is too long' do
      user = build :user, country: 'Test' * 10

      expect(user.valid?).to eq(false)
      expect(user.errors[:country]).to eq(['is too long (maximum is 35 characters)'])
    end
  end

  describe 'City' do
    it 'is invalid when city is too long' do
      user = build :user, city: 'Test' * 10

      expect(user.valid?).to eq(false)
      expect(user.errors[:city]).to eq(['is too long (maximum is 35 characters)'])
    end
  end

  describe 'Address' do
    it 'is invalid when address is too long' do
      user = build :user, address: 'Test' * 52

      expect(user.valid?).to eq(false)
      expect(user.errors[:address]).to eq(['is too long (maximum is 140 characters)'])
    end
  end

  describe 'Bio' do
    it 'is invalid when bio is too long' do
      user = build :user, bio: 'Test' * 150

      expect(user.valid?).to eq(false)
      expect(user.errors[:bio]).to eq(['is too long (maximum is 500 characters)'])
    end
  end

  describe '.full_name' do
    it "return user's full name" do
      expect(@user.full_name).to eq("#{@user.first_name} #{@user.last_name}")
    end
  end

  describe 'remember token' do
    before { @user.save }

    it 'does not blank' do
      expect(:remember_token).to_not be_blank
    end
  end

  describe 'post associations' do
    before { @user.save }

    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end

    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it 'should have the right microposts in the right order' do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end
  end

  describe 'following' do
    let(:other_user) { FactoryGirl.create(:user) }

    before do
      @user.save
      @user.follow(other_user)
    end

    it 'follows user' do
      expect(@user).to be_following(other_user)
    end

    describe 'and unfollowing' do
      before { @user.unfollow(other_user) }

      it 'unfollows user' do
        expect(@user).to_not be_following(other_user)
      end
    end
  end

  describe '#remember' do
    let(:user) { build :user }

    it { expect { user.send(:remember) }.to change { user.remember_digest }.from(nil).to(String) }
  end

  describe '#forget' do
    let(:user) { build :user }

    before do
      user.send(:remember)
    end

    it { expect { user.send(:forget) }.to change { user.remember_digest }.from(String).to(nil) }
  end

  describe '#activate' do
    let(:user) { build :user, activated: false, activated_at: nil }

    it { expect { user.send(:activate) }.to change { user.activated }.from(false).to(true) }
    it { expect { user.send(:activate) }.to change { user.activated_at }.from(nil).to(Time) }
  end

  describe '#create_reset_digest' do
    let(:user) { build :user }

    it { expect { user.send(:create_reset_digest) }.to change { user.reset_digest }.from(nil).to(String) }
  end
end
