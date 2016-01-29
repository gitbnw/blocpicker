class Stock < ActiveRecord::Base

    include StocksHelper

    #has_many :picks
    has_and_belongs_to_many :portfolios, -> { uniq } #, through: :picks
    validates :symbol, uniqueness: true

    default_scope { order('updated_at DESC') }

    def self.find_or_remote_find(param)
      stock = self.find_by(param)
      if !stock || stock.updated_at < Time.now - 5.minutes
        stock = self.request_remote(param)
      end
      stock
    end

    private

    # def self.update_or_create(attributes)
    #   assign_or_new(attributes)
    # end

    def self.assign_or_new(attributes)

      obj = first || new
      obj.assign_attributes(attributes)
      obj
    end

    def self.request_remote(param)
      RemoteStock.find(param[:symbol])
    end
end
