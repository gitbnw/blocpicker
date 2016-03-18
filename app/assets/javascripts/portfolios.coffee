# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
checkTime = ->
  d = new Date
  # current time
  hours = d.getHours()
  mins = d.getMinutes()
  day = d.getDay()
  day >= 1 and day <= 5 and hours >= 9 and (hours < 17 or hours == 17 and mins <= 30)

turbolinksSetInterval = (intervalFunction, seconds) ->
  interval = setInterval(intervalFunction, seconds)

  removeInterval = ->
    clearInterval interval
    $(document).off 'page:change', removeInterval
    return

  $(document).on 'page:change', removeInterval
  return


IsJsonString = (str) ->
  try
    JSON.parse str
  catch e
    return false
  true

refresh_quotes = (stock_ids) ->
  portfolio_id = window.portfolio_id
  url = "../api/v1/stocks/refresh"
  if stock_ids.length > 0
    $.ajax
      url: url
      type: "POST"
      data: {stock_ids, portfolio_id}
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
         console.log "AJAX Error: #{errorThrown}"
      success: (stocks_data, textStatus, jqXHR) ->
        url = "../stocks/refresh"
        $.ajax
          url: url
          type: "POST"
          data: {stock_ids, portfolio_id}
          dataType: "script"        
          error: (jqXHR, textStatus, errorThrown) ->
            console.log "AJAX 2 Error: #{errorThrown}"
          success: (stocks_html, textStatus, jqXHR) ->  

            

refresh_portfolio = ->
  gon.watch 'expired_stocks_ids', refresh_quotes

checkRefresh = ->
  refresh_rate = window.refresh_rate
  turbolinksSetInterval(refresh_portfolio, refresh_rate)
  return

myStopFunction = ->
  clearInterval checkRefresh
  return

@init_refresh = (myCount) ->
  console.log '@init_refresh called'
  if myCount > 0
    # if checkTime()
    #
    $ checkRefresh
  else

    $ myStopFunction

@init_count = (@portfolio_id, @refresh_rate) ->
  window.portfolio_id = @portfolio_id
  window.refresh_rate = @refresh_rate
  gon.watch 'myCount', @init_refresh
