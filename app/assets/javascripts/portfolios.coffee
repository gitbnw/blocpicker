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
    console.log 'removeInterval called'
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
  url = "refresh"
  console.log 'refresh_quotes called'
  if stock_ids.length > 0
    console.log 'expired stocks_ids exist'
    $.ajax
      url: url
      type: "POST"
      data: {stock_ids, portfolio_id}
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
         $('body').append "AJAX Error: #{textStatus}"
      success: (stocks_data, textStatus, jqXHR) ->
        $.each stocks_data, (index, stock) ->
          if stock['tick'] = 'none'
            #rebuild render and apply css effects to show bold fade back to normal
            $('#stock-'+stock['id']).html('font-weight','Bold');
          else if stock['tick'] = 'up'  
            #rebuild render and apply css effects to show bold green fade back to normal
            $('#stock-'+stock['id']).html('font-weight','Bold');
          else
            #rebuild render and apply css effects to show bold red fade back to normal
            $('#stock-'+stock['id']).html('font-weight','Bold');            
        #     $.each stock_array, (stock) ->
        #       stock_render = $('<%= raw render(stock) %>')
        #       $('body').append stock_render
        #       return
        #   return   
        #  $('.js-stocks').hide().html(data).fadeIn 'slow', -> return

refresh_portfolio = ->
  console.log 'refresh_portfolio called'
  gon.watch 'expired_stocks_ids', refresh_quotes

checkRefresh = ->
  console.log 'checkRefresh called'
  turbolinksSetInterval(refresh_portfolio, 10000)
  return

myStopFunction = ->
  console.log 'myStopFunction called'
  clearInterval checkRefresh
  return

@init_refresh = (myCount) ->
  console.log '@init_refresh called'
  if myCount > 0
    console.log 'portfolio has stocks, refresh'
    # if checkTime()
    #
    $ checkRefresh
  else
    console.log 'portfolio has no stocks, stop refresh'

    $ myStopFunction

@init_count = (@portfolio_id) ->
  window.portfolio_id = @portfolio_id
  console.log '@init count called'
  gon.watch 'myCount', @init_refresh
