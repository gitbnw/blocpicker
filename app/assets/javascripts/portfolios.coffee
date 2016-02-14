# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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

refresh_quotes = (ids) ->
  console.log ids
  url = "http://localhost:3000/api/v1/stocks/refresh"
  $.ajax
    url: url
    type: "POST"
    data: {ids}
    dataType: "json"
    error: (jqXHR, textStatus, errorThrown) ->
       $('body').append "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
       $('body').append "Successful AJAX call: #{data}";
       $('.js-stocks').hide().html("#{escape_javascript render(@portfolio.stocks)}").fadeIn 'slow', ->
         return

refresh_portfolio = ->
  console.log 'refresh_portfolio called'
  gon.watch 'expired_stocks_ids', refresh_quotes

checkRefresh = ->
  console.log 'checkRefresh called'
  turbolinksSetInterval(refresh_portfolio, 60000)
  return

myStopFunction = ->
  console.log 'myStopFunction called'
  clearInterval checkRefresh
  return

@init_refresh = (myCount) ->
  console.log '@init_refresh called'
  if myCount > 0
    console.log 'portfolio has stocks, refresh'
    $ checkRefresh
  else
    console.log 'portfolio has no stocks, stop refresh'
    $ myStopFunction

@init_count = ->
  console.log '@init count called'
  gon.watch 'myCount', @init_refresh
