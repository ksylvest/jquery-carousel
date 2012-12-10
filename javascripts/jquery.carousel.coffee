###
jQuery Carousel
Copyright 2010 - 2012 Kevin Sylvestre
###

"use strict"

$ = jQuery

class Animation
  @transitions:
    "webkitTransition": "webkitTransitionEnd"
    "mozTransition": "mozTransitionEnd"
    "msTransition": "msTransitionEnd"
    "oTransition": "oTransitionEnd"
    "transition": "transitionend"

  @transition: ($el) ->
    el = $el[0]
    return result for type, result of @transitions when el.style[type]?

class Carousel

  @defaults: {}

  constructor: ($el, settings = {}) ->
    @$el = $el
    @settings = $.extend {}, Carousel.defaults, settings

  next: ->
    @go("next")

  prev: ->
    @go("prev")

  $fallback: (direction) ->
    method = switch direction
      when "prev" then "last"
      when "next" then "first"
    @$(".previews .preview")[method]()

  $active: ->
    @$(".previews .preview.active")

  inverse: (direction) ->
    switch direction
      when "next" then "prev"
      when "prev" then "next"

  go: (direction) ->
    $active = @$active()
    animating = "#{direction}ing"

    $pending = $active[direction]()
    $pending = @$fallback(direction) unless $pending.length

    inverse = @inverse(direction)
    transition = Animation.transition($active)

    $pending.addClass(direction)
    $pending.offset().position

    $active.addClass(animating)
    $pending.addClass(animating).addClass(direction)

    callback = ->
      $active.removeClass('active').removeClass(animating)
      $pending.addClass('active').removeClass(animating).removeClass(direction)

    if transition? then $active.one(transition, callback) else callback()

  $: (selector) ->
    @$el.find(selector)

$.fn.extend
  carousel: (option = {}) ->
    @each ->
      $this = $(@)

      data = $this.data("carousel")
      options = $.extend {}, $.fn.carousel.defaults, typeof option is "object" and option
      action = if typeof option is "string" then option else option.action

      $this.data "carousel", data = new Carousel($this, options) unless data?
      data[action]() if action?

$(document).on "click.carousel", "[data-action]", (event) ->
  event.preventDefault()
  event.stopPropagation()

  $this = $(this)
  $target = $this.closest(".carousel")
  options = $.extend {}, $target.data(), $this.data()

  $target.carousel(options)

