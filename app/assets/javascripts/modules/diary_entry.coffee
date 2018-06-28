@GregHome ||= {};

class GregHome.DiaryEntry
  constructor: ->
    @$button = $('.show-menu')
    @$menu = $('nav.menu')
    @init()

  init: ->
    if @$button.length > 0
      @listen()

  listen: ->
    @$button.on 'click', (e) =>
      @menu_toggle()

  menu_toggle: ->
    if @$menu.hasClass 'show'
      @$menu.removeClass 'show'
      @$button.children('i').removeClass('fa-arrow-left').addClass('fa-arrow-right')
    else
      @$menu.addClass 'show'
      @$button.children('i').removeClass('fa-arrow-right').addClass('fa-arrow-left')
