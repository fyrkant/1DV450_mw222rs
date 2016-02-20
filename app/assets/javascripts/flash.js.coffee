$ ->
  $('#flash').on 'click', (e) ->
    e.preventDefault()
    $(this).fadeOut()

  timeout = () ->
    $('#flash').fadeOut()

  setTimeout(timeout, 5000)