require 'resque/tasks'

namespace :update do
  
  # desc "Update stock info by http request"
  # task update_stocks: :environment do
  #   oldest_stock = Stock.oldest.first
  #   old_update = oldest_stock.updated_at
  #   @stocks = Stock.all
  #   @stocks.each do |stock|
  #       Stock.quote_update(stock)
  #       stock.save
  #   end
  #   new_update = Stock.find(oldest_stock.id).updated_at

  #   puts "Oldest stock previously updated #{old_update}"  
  #   puts "Oldest stock now updated #{new_update}"  
  # end
  
  desc "Update history by http request"
  task update_history_all: :environment do

    oldest_history = History.oldest.last
    old_date = oldest_history.date
    @stocks = Stock.all
    symbols = @stocks.pluck(:symbol)
    @stocks.each do |stock|
      History.find_or_complete(stock)
    end
    History.expired.delete_all
    
    oldest_history_now = History.oldest.last
    new_date = oldest_history_now.date

    puts "stocks #{symbols}"
    puts "Oldest history date previously #{old_date}"  
    puts "Oldest history date now  #{new_date}" 
end
  
  

end
