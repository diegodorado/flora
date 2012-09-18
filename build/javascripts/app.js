(function() {
  var bind_contact_links, colorize, format_posts, kill_lightbox, pager_hack, remove_posts, set_body_class, set_posts_class, set_text_widget_classes;

  kill_lightbox = function() {
    return $("a[href$=\"jpg\"],a[href$=\"png\"]").each(function(i, el) {
      var html;
      html = this.innerHTML;
      return this.innerHTML = html;
    });
  };

  set_body_class = function() {
    var path;
    path = window.location.pathname;
    if (path === '/p/que-hace-esta-chica.html') {
      $('body').addClass('que-hace');
    }
    if (path === '/p/flora-va-de-compras.html') {
      $('body').addClass('compras');
    }
    if (path === '/search/label/biblioteca') {
      $('body').removeClass('index').addClass('biblioteca');
    }
    if (path === '/search/label/portfolio') {
      $('body').removeClass('index').addClass('portfolio');
    }
    if ($('body').hasClass('item')) {
      $('body').removeClass('item');
      if ($('.post-labels .biblioteca').size() > 0) {
        return $('body').addClass('biblioteca');
      } else if ($('.post-labels .portfolio').size() > 0) {
        return $('body').addClass('portfolio');
      } else {
        return $('body').addClass('index');
      }
    }
  };

  remove_posts = function() {
    return $('body.index .post-outer.portfolio').remove();
  };

  set_text_widget_classes = function() {
    return $('.widget.Text').each(function() {
      return $(this).addClass("" + ($(this).find('.title').text()) + "-text");
    });
  };

  format_posts = function() {
    return $('.post-outer .post-body').each(function() {
      var $set;
      $(this).find('div, center, span').contents().unwrap();
      $(this).find('div, center, span').remove();
      $(this).find('.tr-caption-container, .tr-caption, a').attr('style', '');
      $set = $();
      $(this).contents().each(function() {
        if ($(this).is("br, table, img, ul, ol, h2") || !this.nextSibling) {
          if ($set.size() > 0) {
            $set.wrapAll("<p />");
          }
          return $set = $();
        } else {
          if ($.trim($(this).text()).length > 0) {
            return $set.push(this);
          }
        }
      });
      $(this).find('> br').remove();
      $(this).find('> img').each(function() {
        var caption, img, template;
        caption = $.trim($(this).next('p').text());
        if (!(caption[0] === '(' && caption[caption.length - 1] === ')')) {
          caption = '';
        }
        img = $(this).clone().wrap('<p>').parent().html();
        caption = '';
        template = "      <table cellpadding=\"0\" cellspacing=\"0\" class=\"tr-caption-container\">        <tbody>          <tr><td>" + img + "</td></tr>          <tr><td class=\"tr-caption\">" + caption + "</td></tr>        </tbody>      </table>";
        return $(this).replaceWith(template);
      });
      if ($.browser.msie) {
        return $(this).find('img').width(673);
      }
    });
  };

  colorize = function() {
    var colors, rand, selected;
    if ($('body').hasClass('que-hace')) {
      return $('body').addClass("color-i");
    } else {
      colors = 'hecfdbga'.split('');
      rand = Math.floor(Math.random() * (colors.length - 1));
      colors = colors.slice(rand, (colors.length - 1) + 1 || 9e9).concat(colors.slice(0, rand));
      selected = colors.shift();
      $('body').addClass("color-" + selected);
      return $('.widget.BlogArchive .archivedate .zippy').closest('.archivedate').each(function(i) {
        if ($(this).hasClass('expanded')) {
          return $(this).addClass("archive-color-" + selected);
        } else {
          return $(this).addClass("archive-color-" + colors[i % colors.length]);
        }
      });
    }
  };

  bind_contact_links = function() {
    return $('body.que-hace .widget.HTML .contact-box, #footer .contact').bind('click', function(event) {
      return $(this).toggleClass('open');
    });
  };

  set_posts_class = function() {
    $('.post-outer .post-labels .biblioteca').closest('.post-outer').addClass('biblioteca');
    return $('.post-outer .post-labels .portfolio').closest('.post-outer').addClass('portfolio');
  };

  pager_hack = function() {
    var fake;
    fake = '<a class="page" href="#"></a>';
    if ($('#pager .newer').size() === 0) {
      $('#pager').prepend(fake);
    }
    if ($('#pager .older').size() === 0) {
      return $('#pager').append(fake);
    }
  };

  $(function() {
    kill_lightbox();
    set_posts_class();
    set_body_class();
    remove_posts();
    format_posts();
    set_text_widget_classes();
    colorize();
    bind_contact_links();
    pager_hack();
    $(document.links).filter(function() {
      return this.hostname !== window.location.hostname;
    }).attr('target', '_blank');
    return $('body').removeClass('loading');
  });

}).call(this);
