# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



@copy = (tick_color, canvas) ->
  ctx = canvas.getContext('2d')
  sx = 0
  intervals = 50
  canvas_width = canvas.getAttribute('width')
  canvas_height = canvas.getAttribute('height')
  tick_width = canvas.getAttribute('width') / intervals
  canvas_left = canvas.getAttribute('clientLeft')
  imgData = ctx.getImageData(tick_width, canvas_left, canvas_width - tick_width, 14)    
  ctx.putImageData imgData, 0, 0
  ctx.fillStyle = tick_color
  ctx.fillRect canvas_width - tick_width, 0, tick_width, canvas_height