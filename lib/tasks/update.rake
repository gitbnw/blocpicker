namespace :update do
  desc "Update stock info by http request"
  task update_stocks: :environment do
    oldest_stock = Stock.oldest.first
    old_update = oldest_stock.updated_at
    @stocks = Stock.all
    @stocks.each do |stock|
        Stock.quote_update(stock)
        stock.save
    end
    new_update = Stock.find(oldest_stock.id).updated_at

    puts "Oldest stock previously updated #{old_update}"  
    puts "Oldest stock now updated #{new_update}"  
  end
  

end
