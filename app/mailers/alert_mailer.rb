class AlertMailer < ActionMailer::Base
  default from: "youremail.com"

   def flip_term alert
    alert.position_initial == "above" ? "below" : "above" 
   end
   
   def alert_fired(alert)
    
     @alert = alert
     @stock = @alert.stock
     @user = @alert.user
     
     headers["Message-ID"] = "<alert/#{@alert.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<alert/#{@alert.id}@your-app-name.example>"
     headers["References"] = "<stock/#{@stock.id}@your-app-name.example>"

     mail(to: @user.email, subject: "Blocpicker Alert: #{@stock.symbol} has gone #{flip_term @alert} #{@alert.price_target}")
   end
   

end