$ ->
  kill_lightbox()

kill_lightbox = ->
  $("a[href$=\"jpg\"],a[href$=\"png\"]").each (i, el) ->
    html = @innerHTML
    @innerHTML = html
