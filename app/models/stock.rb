class Stock < ActiveRecord::Base

    include StocksHelper

    has_many :picks
    has_many :portfolios, through: :picks

    default_scope { order('updated_at DESC') }

    def self.find_or_remote_find(symb)
      stock = self.find_by(symbol: symb)
      if !stock || stock.updated_at < Time.now.beginning_of_day - 6.hours
        stock = self.request_remote(symb)
      end
    end

    private

    def self.update_or_create(attributes)
      assign_or_new(attributes)
    end

    def self.assign_or_new(attributes)

      obj = first || new
      obj.assign_attributes(attributes)
      obj
    end

    def self.request_remote(param)
      RemoteStock.find(param[:symbol])
    end
end
