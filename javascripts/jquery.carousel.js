/*!
 * jQuery Carousel
 *
 * Copyright 2010 - 2012 Kevin Sylvestre
 */

(function ($) {
  
  $.fn.carousel = function(options) {
    
    var settings = {
      duration: 400,
      axis:     'x',
      spacing:  '10',
      active:   'active',
      easing:   'swing',
      prev:     '.prev',
      next:     '.next',
      page:     '.page',
      preview:  '.preview',
      overflow: '.overflow',
    };
    
    if (options) ($.extend(settings, options));
    
    var $prev = $(this).find(settings['prev']);
    var $next = $(this).find(settings['next']);
    var $pages = $(this).find(settings['page']);
    var $previews = $(this).find(settings['preview']);
    var $overflow = $(this).find(settings['overflow']);
    
    $overflow.css({ position: "relative" });
    
    $overflow.css({ margin:  "-" + settings['spacing'] + "px" });  
    $previews.css({ padding: "+" + settings['spacing'] + "px" });
    
    var size = $previews.length;
    
    var width = $previews.outerWidth(true);
    var height = $previews.outerHeight(true);
    
    if (settings['axis'] == 'x') { $overflow.css({ width: width   * size + "px", height: height + "px" }) };
    if (settings['axis'] == 'y') { $overflow.css({ height: height * size + "px", width:  width  + "px" }) };
    
    var current = 0;
    
    function reposition() {
      
      $pages.removeClass(settings['active']);
      $($pages[current]).addClass(settings['active']);
      
      var properties = {};
      
      if (settings['axis'] == 'x') properties = { right:  current * width  };
      if (settings['axis'] == 'y') properties = { bottom: current * height };
      
      $overflow.stop().animate(properties, settings['duration'], settings['easing']);
       
    }
    
    $pages.each(function (i) {
      
      if (i == current) $(this).addClass(settings['active']);
      
      $(this).click(function (e) {
        e.preventDefault();
        current = i;
        reposition();
      });
      
    });
    
    $next.click(function (e) {
      e.preventDefault();
      current++; current += size; current %= size;
      reposition();
    });
    
    $prev.click(function (e) {
      e.preventDefault();
      current--; current += size; current %= size;      
      reposition();
    });
    
  };
  
}) (jQuery);