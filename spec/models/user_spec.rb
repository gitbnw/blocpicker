require 'rails_helper'


RSpec.describe User, type: :model do

let(:user) { create(:user) }

  describe "attributes" do

    it "should respond to email" do
      expect(user).to respond_to(:email)
    end

    it "should respond to name" do
      expect(user).to respond_to(:name)
    end

    it "should respond to password" do
      expect(user).to respond_to(:password)
    end

  end

  it "has a valid factory" do
    user = FactoryGirl.create(:user)
    user.valid?
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, name: nil).should_not be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without a password" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
 end

end
