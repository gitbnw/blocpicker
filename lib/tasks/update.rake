namespace :update do
  
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
