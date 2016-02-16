# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
autoComplete = ->
  $("#search-key-input").autocomplete
    source: "/admin/search.json"
$(document).ready(autoComplete)
$(document).on('page:load', autoComplete)
