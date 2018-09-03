@GregHome ||= {}

class GregHome.Confirmation
  constructor: ->
    @$confirm_message = $('div.confirm--content span#message')
    @$confirm_background = $('div.confirm--background')
    @$confirm_close = $('div.confirm--buttons a#cancel')
    @$confirm_button = $('div.confirm--buttons a#confirm')
    @init()

  init: ->
    if @$confirm_message.length > 0
      @listen()

  listen: ->
    $('body').on 'click', 'a.confirmation', (e) =>
      e.preventDefault()
      link = $(e.currentTarget)
      @$confirm_message.html(link.data('confirmation-message'))
      @$confirm_button.attr('href', link.attr('href'))
      @$confirm_button.attr('target', link.attr('target'))
      @$confirm_button.attr('data-method', link.attr('data-method'))
      $('div.confirm').removeClass('hidden')
      return false

    @$confirm_background.on 'click', (e) =>
      $('div.confirm').addClass('hidden')

    @$confirm_close.on 'click', (e) =>
      $('div.confirm').addClass('hidden')
