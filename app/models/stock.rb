class Stock < ActiveRecord::Base
  
include StocksHelper
    
    before_save :request_remote

    
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
    
    def request_remote
      RemoteStock.find(self.symbol)
    end
end
