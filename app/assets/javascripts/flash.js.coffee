$ ->
  $('#flash').on 'click', (e) ->
    e.preventDefault()
    $(this).toggle()

  timeout = () ->
    $('#flash').toggle()

  setTimeout(timeout, 5000)