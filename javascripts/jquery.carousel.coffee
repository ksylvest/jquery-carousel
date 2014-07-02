###
jQuery Carousel
Copyright 2010 - 2014 Kevin Sylvestre
1.1.8
###

"use strict"

$ = jQuery

class Animation
  @transitions:
    "webkitTransition": "webkitTransitionEnd"
    "mozTransition": "mozTransitionEnd"
    "oTransition": "oTransitionEnd"
    "transition": "transitionend"

  @transition: ($el) ->
    el = $el[0]
    return result for type, result of @transitions when el.style[type]?

  @execute: ($el, callback) ->
    transition = @transition($el)
    if transition? then $el.one(transition, callback) else callback()

class Carousel

  @defaults: {}

  constructor: ($el, settings = {}) ->
    @$el = $el
    @settings = $.extend {}, Carousel.defaults, settings
    @$previews().first().toggleClass('active') unless @$active().length

  next: ->
    @go("next")

  prev: ->
    @go("prev")

  $fallback: (direction) ->
    method = switch direction
      when "prev" then "last"
      when "next" then "first"
    @$(".previews .preview")[method]()

  $previews: ->
    @$(".previews .preview")

  $active: ->
    @$(".previews .preview.active")

  swap: ($active, $pending, direction, activated = 'active') ->
    animating = "#{direction}ing"

    $pending.addClass(direction)
    $pending.offset().position

    $active.addClass(animating)
    $pending.addClass(animating)

    callback = ->
      $active.removeClass(activated).removeClass(animating)
      $pending.addClass(activated).removeClass(animating).removeClass(direction)

    Animation.execute($active, callback)


  page: (index) ->
    $active = @$active()
    $pending = @$previews().eq(index)

    existing = @$previews().index($active)
    direction = if existing > index then 'prev' else 'next'

    return if $pending.is($active)

    @swap($active, $pending, direction)

  go: (direction) ->
    $active = @$active()

    $pending = $active[direction]()
    $pending = @$fallback(direction) unless $pending.length

    return if $pending.is($active)

    @swap($active, $pending, direction)

  $: (selector) ->
    @$el.find(selector)

$.fn.extend
  carousel: (option = {}) ->
    @each ->
      $this = $(@)

      data = $this.data("carousel")
      options = $.extend {}, $.fn.carousel.defaults, typeof option is "object" and option
      action = if typeof option is "string" then option else option.action
      page = option.page unless typeof options is "string"

      $this.data "carousel", data = new Carousel($this, options) unless data?
      data[action]() if action?
      data.page(options.page) if page?
      

$(document).on "click.carousel", "[data-action],[data-page]", (event) ->
  $this = $(this)
  $target = $this.closest(".carousel")
  return unless $target.length

  event.preventDefault()
  event.stopPropagation()

  options = $.extend {}, $target.data(), $this.data()

  $target.carousel(options)

$ ->
  $('.carousel').each ->
    $(this).carousel()
