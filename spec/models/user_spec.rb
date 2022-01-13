require 'rails_helper'

RSpec.describe User, type: :model do
describe 'Validations' do

      it "User should have password" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password_confirmation: "password")
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "User should have confirm password" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password: "password")
        expect(@user.valid?).to eq(false)
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it "User should have password = confirm password" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password: "4321", 
          password_confirmation: "password")
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "Password should have minimum length of 4 characteres" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password: "123", 
          password_confirmation: "123")
        expect(@user.valid?).to eq(false)
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
      end

      it "User should have email" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "Mill", p
          assword: "password", passwo
          rd_confirmation: "
          password")
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "Email should be unique" do
        @user = User.create(
          first_name: "Larry", 
        last_name: "LHL", 
        email: "TEST@TEST.com", password: "password", 
        password_confirmation: "password")
        expect(@user.valid?).to eq(true)

        @user2 = User.create(
          first_name: "Ed2", 
          last_name: "LHL2", email: "test@test.COM", 
          password: "password", 
          password_confirmation: "password")
        expect(@user2.valid?).to eq(false)
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end

      it "User should have first name" do
        @user = User.create(
          last_name: "LHL", 
          email: "test@test.com", 
          password: "password", 
          password_confirmation: "password")
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "User should have last name" do
        @user = User.create(
          first_name: "LHL", 
          email: "test@test.com", 
          password: "password", 
          password_confirmation: "password")
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end


  describe '.authenticate_with_credentials' do

    it "User should login with the correct password" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password: "password", 
          password_confirmation: "password")
        expect(User.authenticate_with_credentials("test@test.com", "password").present?).to eq(true)
    end

    it "User should not login with the wrong password" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password: "password", 
          password_confirmation: "password")
        expect(User.authenticate_with_credentials("test@test.com", "12345").present?).to eq(false)
    end

    it "User should login with spaces before email" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password: "password", 
          password_confirmation: "password")
        expect(User.authenticate_with_credentials(" test@test.com", "password").present?).to eq(true)
    end

    it "User should login with spaces after email" do
        @user = User.create(
          first_name: "Larry", 
          last_name: "LHL", 
          email: "test@test.com", 
          password: "password", 
          password_confirmation: "password")
        expect(User.authenticate_with_credentials("test@test.com ", "password").present?).to eq(true)
    end

    it "Should pass if email even if case insenitive" do
      @user = User.create(
        first_name: "Larry", 
        last_name: "LHL", 
        email: "test@test.com", 
        password: "password", 
        password_confirmation: "password")
      expect(User.authenticate_with_credentials("tEsT@tEsT.com", "password").present?).to eq(true)
    end

  end

end