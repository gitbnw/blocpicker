# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


canvasArr = []


@colorize = (canvasObj) ->
  i = 0
  while i < canvasObj['ArrColor'].length
    stop = i / canvasObj['ArrColor'].length
    canvasObj['gradi'].addColorStop(stop, canvasObj['ArrColor'][i])
    i++
  return canvasObj['gradi']
    
@show = (canvas, tick_color = "white") ->
  ctx = canvas.getContext('2d')
  gradi = ctx.createLinearGradient(0, 0, 200, 0);
  
  find_canvasObj = $.grep canvasArr, (canvasObj, i) ->
    canvasObj["canvas"] == canvas 
  
  if jQuery.isEmptyObject(find_canvasObj) #does not exist yet
    canvasObj = {}
    canvasObj['gradi'] = gradi
    canvasObj['canvas'] = canvas
    canvasObj['ArrColor'] = Array.apply(null, Array(10)).map ->
      'white'
      
    canvasArr.push(canvasObj)
    this_canvasObj = canvasObj
  else
    this_canvasObj = find_canvasObj[0]
  
  this_canvasObj['gradi'] = gradi
  this_canvasObj['ArrColor'].pop()
  this_canvasObj['ArrColor'].unshift(tick_color)
  ctx.fillStyle = colorize(this_canvasObj);
  ctx.fillRect(0,0,200,14); 
