require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  context "validation" do

    it 'should not save a user without a username' do
      expect(FactoryGirl.build(:user, username: nil)).to_not be_valid
    end

    it 'should not save a user without an email' do
      expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
    end

    it 'should not save a user without a password' do
      expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
    end

    it 'should not save with an invalid email' do
      expect(FactoryGirl.build(:user, email: "nothing")).to_not be_valid
    end

    it 'should not save a user with invalid characters in their username' do
      expect(FactoryGirl.build(:user, username: '@user name')).to_not be_valid
    end

    it 'should require usernames to be at least 3 characters' do
      expect(FactoryGirl.build(:user, username: "uu")).to_not be_valid
    end

    it 'should limit usernames to 30 characters' do
      expect(FactoryGirl.build(:user, username: "uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu")).to_not be_valid
    end

  end

end