require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:stock) { create(:stock) }

  describe 'attributes' do
    it 'should respond to symbol' do
      expect(stock).to respond_to(:symbol)
    end

    it 'should respond to name' do
      expect(stock).to respond_to(:name)
    end

    it 'should respond to price' do
      expect(stock).to respond_to(:price)
    end

    it 'should respond to change' do
      expect(stock).to respond_to(:change)
    end

    it 'should respond to volume' do
      expect(stock).to respond_to(:volume)
    end
  end
end
