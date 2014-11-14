###
jQuery Carousel
Copyright 2010 - 2014 Kevin Sylvestre
1.2.0
###

"use strict"

$ = jQuery

class Timer
  @every: (duration, callback) ->
    setInterval(callback, duration)

  @after: (duration, callback) ->
    setTimeout(callback, duration)

  @clear: (interval) ->
    clearInterval(interval)

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

  @defaults: { cycle: 5000, active: 'active' }

  constructor: ($el, settings = {}) ->
    @$el = $el
    @settings = $.extend {}, Carousel.defaults, settings
    unless @$active().length
      @$pages().first().toggleClass(@settings.active)
      @$previews().first().toggleClass(@settings.active)

    if settings.cycle?
      @cycle()
      @$el.on('mouseenter', $.proxy(@pause, @))
      @$el.on('mouseleave', $.proxy(@cycle, @))

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

  $pages: ->
    @$(".pages .page")

  $active: ->
    @$(".previews .preview.active")

  cycle: ->
    @timer ?= Timer.every(@settings.cycle, $.proxy(@next || @prev, @))

  pause: ->
    Timer.clear(@timer) if @timer
    delete @timer

  swap: ($active, $pending, direction, activated = @settings.active) ->
    cycling = @interval
    animating = "#{direction}ing"
    index = @$previews().index($pending)

    console.debug(index)

    $pages = @$pages()

    $pending.addClass(direction)
    $pending.offset().position

    $active.addClass(animating)
    $pending.addClass(animating)

    $pages.removeClass(activated)

    callback = ->
      $active.removeClass(activated).removeClass(animating)
      $pending.addClass(activated).removeClass(animating).removeClass(direction)

      $($pages.get(index)).addClass(activated)

    Animation.execute($active, callback)

  page: (index) ->
    @pause()

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
