# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

canvasArr = []

@colorize = (canvasObj) ->
  i = 0
  while i < canvasObj['colorArray'].length
    stop = i / canvasObj['colorArray'].length
    canvasObj['gradi'].addColorStop(stop, canvasObj['colorArray'][i])
    i++
  return canvasObj['gradi']
    
@show = (canvas, colorArray, width) ->

  ctx = canvas.getContext('2d')

  gradi = ctx.createLinearGradient(0, 0, width, 0);

  find_canvasObj = $.grep canvasArr, (canvasObj, i) ->
    canvasObj["canvas"] == canvas 
  
  canvasObj = {}
  canvasObj['gradi'] = gradi
  canvasObj['canvas'] = canvas
  canvasObj['colorArray'] = colorArray
    
  canvasArr.push(canvasObj)
  this_canvasObj = canvasObj

  this_canvasObj['gradi'] = gradi
  ctx.fillStyle = colorize(this_canvasObj);
  ctx.fillRect(0,0,width,24); 

$(document).on 'ready turbolinks:load', ->
  $('.tag-tooltip').tooltip()
  return