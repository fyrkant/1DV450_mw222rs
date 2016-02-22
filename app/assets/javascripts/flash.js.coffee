$ ->
  $('#flash').on 'click', (e) ->
    e.preventDefault()
    $(this).slideUp()

  timeout = () ->
    $('#flash').slideUp()

  setTimeout(timeout, 5000)