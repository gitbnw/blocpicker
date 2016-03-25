$(document).on 'page:change', ->
  $('.alert').delay(2000).slideUp 500, ->
    $('.alert').alert 'close'
    return
  return