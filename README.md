# jQuery Carousel

Carousel is a jQuery plugin created to provide a scrolling gallery.

## Installation

To install copy the *javascripts* and *stylesheets* directories into your project and add the following snippet to the header:

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js" type="text/javascript"></script>
    <script src="javascript/jquery.carousel.js" type="text/javascript"></script>
    <link href="stylesheets/jquery.carousel.css" rel="stylesheet" type="text/css" />

## Example

Setting up a carousel is easy. The following snippet is a good start:
    
    <div class="carousel">
      <div class="previews">
        <div class="preview"><img src="samples/sample-01.png" /></div>
        <div class="preview"><img src="samples/sample-02.png" /></div>
        <div class="preview"><img src="samples/sample-03.png" /></div>
        <div class="preview"><img src="samples/sample-04.png" /></div>
      </div>
      <div class='controls'>
        <a class='next' data-action='next' href='#'>›</a>
        <a class='prev' data-action='prev' href='#'>‹</a>
      </div>
    </div>

## Copyright

Copyright (c) 2010 - 2013 Kevin Sylvestre. See LICENSE for details.
