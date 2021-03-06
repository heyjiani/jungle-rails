require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = User.new(
      first_name: 'Billy',
      last_name: 'Zane',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  describe 'Validations' do
    it "successfully creates a user when all fields are filled and validated" do
      @user.save
      
      created_user = User.find(@user.id)
      expect(created_user).to eq(@user)
    end

    context 'given empty name fields' do
      it "throws an error when first name is blank" do
        @user.first_name = nil
        @user.save

        test_errors = @user.errors.full_messages
  
        expect(test_errors).to include "First name can't be blank"
      end

      it "throws an error when last name is blank" do
        @user.last_name = nil
        @user.save

        test_errors = @user.errors.full_messages
  
        expect(test_errors).to include "Last name can't be blank"
      end
    end

    context 'given invalid password' do
      it "throws an error when password and password_confirmation fields don't match" do
        @user.password_confirmation = 'PaSsWoRd'
        @user.save
        test_errors = @user.errors.full_messages
  
        expect(test_errors).to include "Password confirmation doesn't match Password"
      end

      it "throws an error when password is blank" do
        @user.password = nil
        @user.save
        test_errors = @user.errors.full_messages

        expect(test_errors).to include "Password can't be blank"
      end
      
      it "throws an error when password confirmation is blank" do
        @user.password_confirmation = nil
        @user.save
        test_errors = @user.errors.full_messages

        expect(test_errors).to include "Password confirmation can't be blank"
      end

      it "throws an error when password is shorter than 6 characters" do
        @user.password = 'test'
        @user.password_confirmation = 'test'
        @user.save
        test_errors = @user.errors.full_messages

        expect(test_errors).to include "Password is too short (minimum is 6 characters)"
      end
    end

    context 'given invalid email' do
      it "throws an error when email is blank" do
        @user.email = nil
        @user.save
        test_errors = @user.errors.full_messages

        expect(test_errors).to include "Email can't be blank"
      end

      it "throws an error when email already exists in database" do
        @user.save
        @user2 = User.new(
          first_name: 'Willy',
          last_name: 'Pane',
          email: 'TEST@TEST.com',
          password: 'password',
          password_confirmation: 'password'
        )
        @user2.save
        test_errors = @user2.errors.full_messages

        expect(test_errors).to include "Email has already been taken"
      end
    end
  end

  describe '.authenticate_with_credentials' do

    context "logging in with the right email and password" do
      it "lets the user log in" do
        @user.save
        login = User.authenticate_with_credentials('test@test.com', 'password')
  
        expect(login).to eq(@user)
      end

      it "lets the user log in when email contains whitespace" do
        @user.save
        login = User.authenticate_with_credentials(' test@test.com ', @user.password)
  
        expect(login).to eq(@user)
      end

      it "lets the user log in if they accidentally capitalize any character in email" do
        @user.save
        login = User.authenticate_with_credentials('TEsT@tEST.COM', @user.password)
  
        expect(login).to eq(@user)
      end
    end

    it "does not let user log in with the wrong password" do
      @user.save
      login = User.authenticate_with_credentials(@user.email, 'abc')

      expect(login).to eq(nil)
    end

    it "does not let user log in with the wrong email" do
      @user.save
      login = User.authenticate_with_credentials('abc@abc.com', @user.password)

      expect(login).to eq(nil)
    end
  end

end
