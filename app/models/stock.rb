require 'httparty'

class Stock < ActiveRecord::Base
    
    belongs_to :portfolio
    before_save :lookup_quote
    
    validates :symbol, length: { maximum: 4 }, presence: true
    validates :price, presence: true
    
    default_scope { order('updated_at DESC') }

    private
    
   def lookup_quote
     base_query = "select * from yahoo.finance.quote where symbol in"
     puts "hello"
    # query = url_encode(yql_query) 
     
    # response = get("?q=" << query << "(#{symbol})" )
     
   end
   
end
