class AlertMailer < ActionMailer::Base
  default from: "youremail.com"

   def alert_fired(alert)

     @stock = alert.stock
     @user = alert.user
     
     headers["Message-ID"] = "<alert/#{alert.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<alert/#{alert.id}@your-app-name.example>"
     headers["References"] = "<stock/#{@stock.id}@your-app-name.example>"
 

 
    flipped_term
     mail(to: @user.email, subject: "Alert: #{@stock.symbol} has gone #{flip_term} #{@alert.price_initial}")
   end
   
   def flip_term
    alert.position_initial == "above" ? "below" : "above" 
   end
end