$ ->
  clip = new ZeroClipboard($(".clip-button"))

  $(".clip-button").on("click", ->
    blockId = $(this).data('clipboard-target')
    $("#" + blockId).effect("highlight", {color: "#81c784"})
    Materialize.toast('Key saved to clipboard!', 4000)
  )