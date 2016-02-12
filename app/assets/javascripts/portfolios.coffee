# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

IsJsonString = (str) ->
  try
    JSON.parse str
  catch e
    return false
  true

refresh_quotes = (ids) ->
  console.log ids
  console.log IsJsonString(JSON.stringify(ids))
  # $.ajax
  #   url: "api/v1/stocks/refresh"
  #   type: "POST"
  #   data: ids
  #   dataType: "json"
  #   error: (jqXHR, textStatus, errorThrown) ->
  #      $('body').append "AJAX Error: #{textStatus}"
  #   success: (data, textStatus, jqXHR) ->
  #      $('body').append "Successful AJAX call: #{data}"; #refresh-partial

refresh_portfolio = ->
  console.log 'gon fired'
  gon.watch 'expired_stocks_ids', refresh_quotes

checkRefresh = ->
  console.log 'check refresh fired'
  window.setInterval(refresh_portfolio, 5000)
  return

myStopFunction = ->
  console.log 'stop fired'
  clearInterval checkRefresh
  return

init_refresh = (count) ->
  if count > 0
    console.log 'portfolio has stocks, refresh'
    $ checkRefresh
  else
    console.log 'portfolio has no stocks, stop refresh'
    $ myStopFunction

@init_count = ->
  console.log 'portfolio show page open, get count'
  gon.watch 'count', init_refresh
