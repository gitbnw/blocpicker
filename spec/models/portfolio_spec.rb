require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  let(:user) { create(:user) }

  let(:portfolio) { Portfolio.create!(user: user, name: 'Example') }

  it { should belong_to(:user) }

  describe 'attributes' do
    it 'should respond to user' do
      expect(portfolio).to respond_to(:user)
    end

    it 'should respond to name' do
      expect(portfolio).to respond_to(:name)
    end
  end
end
