class Stock < ActiveRecord::Base
    include HTTParty
    
    belongs_to :portfolio
    before_save :lookup_quote
    
    validates :symbol, length: { maximum: 4 }, presence: true
    validates :price, presence: true
    
    default_scope { order('updated_at DESC') }
    
   base_uri "query.yahooapis.com/v1/public/yql"
   
  
    private
    
   def lookup_quote
     base_query = "select * from yahoo.finance.quote where symbol in"
     puts "hello"
    # query = url_encode(yql_query) 
     
    # response = get("?q=" << query << "(#{symbol})" )
     
   end
   
end
