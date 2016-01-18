require 'rails_helper'

RSpec.describe Portfolio, type: :model do

let(:user) { create(:user) }
let(:stock) { create(:stock) }

let(:portfolio) { Portfolio.create!(user: user, stock: stock) }

it { should belong_to(:user) }
it { should belong_to(:stock) }

  describe "attributes" do

    it "should respond to user" do
      expect(portfolio).to respond_to(:user)
    end

    it "should respond to stock" do
      expect(portfolio).to respond_to(:stock)
    end



  end

end
