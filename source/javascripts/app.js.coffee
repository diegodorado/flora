
kill_lightbox = ->
  $("a[href$=\"jpg\"],a[href$=\"png\"]").each (i, el) ->
    html = @innerHTML
    @innerHTML = html

set_body_class = ->
  path = window.location.pathname
  $('body').addClass 'que-hace' if path is '/p/que-hace-esta-chica.html'
  $('body').addClass 'compras' if path is '/p/flora-va-de-compras.html'
  $('body').removeClass('index').addClass 'biblioteca' if path is '/search/label/biblioteca'
  $('body').removeClass('index').addClass 'portfolio' if path is '/search/label/portfolio'
  if $('body').hasClass 'item'
    $('body').removeClass 'item' 
    
    if $('.post-labels .biblioteca').size() > 0
      $('body').addClass 'biblioteca' 
    else if $('.post-labels .portfolio').size() > 0
      $('body').addClass 'portfolio' 
    else
      $('body').addClass 'index' 

  
remove_posts = ->  
  $('body.index .post-outer.portfolio').remove()

set_text_widget_classes = ->
  $('.widget.Text').each ->
    $(@).addClass "#{$(@).find('.title').text()}-text"

format_posts = ->
  $('.post-outer .post-body').each ->
    $(@).find('div, center, span').contents().unwrap()
    $(@).find('div, center, span').remove()
    $(@).find('.tr-caption-container, .tr-caption, a').attr 'style', ''

    $set = $()
    $(@).contents().each ->
      if $(@).is("br, table, img, ul, ol, h2") or not @nextSibling
        $set.wrapAll "<p />" if $set.size() > 0
        $set = $()
      else
        $set.push @ if $.trim($(@).text()).length > 0
        
    $(@).find('> br').remove()

    #todo: match img inside anchors
    $(@).find('> img').each ->
      caption = $.trim $(@).next('p').text()
      caption = '' unless caption[0] is '(' and caption[caption.length-1] is ')'
      img = $(@).clone().wrap('<p>').parent().html() #get full img html
      caption = ''

      template = "
      <table cellpadding=\"0\" cellspacing=\"0\" class=\"tr-caption-container\">
        <tbody>
          <tr><td>#{img}</td></tr>
          <tr><td class=\"tr-caption\">#{caption}</td></tr>
        </tbody>
      </table>"
      $(@).replaceWith(template)


    if $.browser.msie
      #got bored of ie...wont fix
      $(@).find('img').width 673

colorize= ->
  if $('body').hasClass 'que-hace'
    $('body').addClass "color-i"
  else
    colors = 'hecfdbga'.split('')
    rand	= Math.floor(Math.random() * (colors.length - 1))
    colors = colors[rand..(colors.length - 1)].concat colors[0...rand]
    selected = colors.shift()
    $('body').addClass "color-#{selected}"

    $('.widget.BlogArchive .archivedate .zippy').closest('.archivedate').each (i)->
      if $(@).hasClass 'expanded'
          $(@).addClass "archive-color-#{selected}"
      else
          $(@).addClass "archive-color-#{colors[i % colors.length]}"

bind_contact_links= ->
  $('body.que-hace .widget.HTML .contact-box, #footer .contact').bind 'click', (event) ->
    #event.preventDefault()
    $(@).toggleClass 'open'

set_posts_class= ->
  $('.post-outer .post-labels .biblioteca').closest('.post-outer').addClass 'biblioteca'
  $('.post-outer .post-labels .portfolio').closest('.post-outer').addClass 'portfolio'

pager_hack = ->
  #should be done with css... but it's soooo late!!
  fake = '<a class="page" href="#"></a>'
  $('#pager').prepend(fake) if $('#pager .newer').size() is 0
  $('#pager').append(fake) if $('#pager .older').size() is 0
  
  
$ ->
  kill_lightbox()
  set_posts_class()
  set_body_class()
  remove_posts()
  format_posts()
  set_text_widget_classes()
  colorize()
  bind_contact_links()
  pager_hack()
  #open external links in new window
  $(document.links).filter( () -> @hostname != window.location.hostname).attr('target', '_blank')
  $('body').removeClass 'loading'


