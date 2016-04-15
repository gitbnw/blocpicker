require 'rails_helper'

RSpec.describe Alert, type: :model do
    let(:user) { create(:user) }
    let(:portfolio) { create(:portfolio) }
    let(:stock) { create(:stock) }
    let(:alert) { Alert.create!(stock: stock, user: user, price_initial: stock.lasttradepriceonly, price_target: (stock.lasttradepriceonly + 0.5) , start: DateTime.now, expire: (DateTime.now + 3.months)) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:stock) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:stock) }

   describe "attributes" do
     it "responds to price_initial" do
       expect(alert).to respond_to(:price_initial)
     end

     it "responds to price_target" do
       expect(alert).to respond_to(:price_target)
     end
   end
    
end
