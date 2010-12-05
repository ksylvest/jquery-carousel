jQuery Carousel
=============


Carousel is a jQuery plugin designed to provide paginating and scrolling to sites. The carousel supports both x and y axis and can be fully customized.

Installation
------------

To install copy the *images*, *javascripts*, and *stylesheets* directories into your project and add the following snippet to the header:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js" type="text/javascript"></script> 
    <script src="javascript/jquery.carousel.js" type="text/javascript"></script> 
    <link href="stylesheets/style.css" rel="stylesheet" type="text/css" />
  
Examples
--------

Setting up a carousel is easy. The following snippet is a good start:
    
    <div class="carousel">
      <div class="previews">
        <div class="overflow">
          <div class="preview"><img src="images/sample-01.png" /></div>
          <div class="preview"><img src="images/sample-02.png" /></div>
          <div class="preview"><img src="images/sample-03.png" /></div>
          <div class="preview"><img src="images/sample-04.png" /></div>
        </div>
      </div>
      <div class="controls">
        <a href="#" class="next"></a>
        <a href="#" class="prev"></a>
        <a href="#" class="page"></a> 
        <a href="#" class="page"></a> 
        <a href="#" class="page"></a> 
        <a href="#" class="page"></a>
      </div>
    </div>

    <script type="text/javascript">
      $('.carousel').carousel();
    </script>

Copyright
---------

Copyright (c) 2010 Kevin Sylvestre. See LICENSE for details.
