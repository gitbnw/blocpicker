class Stock < ActiveRecord::Base
  
    include StocksHelper
    
    # has_many :picks
    has_many :portfolios, through: :picks
    
    default_scope { order('updated_at DESC') }
    
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
