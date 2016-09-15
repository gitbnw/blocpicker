# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

lookup_symbol = (symbol) ->
    # I should call internal api since i already have rails method for stock lookup
    url = "../api/v1/stocks/get_quote"
    $.ajax
      url: url
      type: "POST"
      data: {symbol}
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
         console.log "AJAX Error: #{errorThrown}"
      success: (stock_data, textStatus, jqXHR) ->
          price = stock_data["LastTradePriceOnly"]
          url = "../alerts/initial_price"
          $.ajax
            url: url
            type: "POST"
            data: {price}
            dataType: "script"        
            error: (jqXHR, textStatus, errorThrown) ->
              console.log "AJAX 2 Error: #{errorThrown}"
              success: (stocks_html, textStatus, jqXHR) -> 

$(document).on "turbolinks:load", ->
    $('#alert_symbol').blur ->
        symbol = $('#alert_symbol').val()
        if symbol.length > 0
            lookup_symbol(symbol)
      return