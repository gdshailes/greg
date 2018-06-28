@GregHome ||= {}

class GregHome.Finances
  constructor: ->
    @$modal_link = $('a.modal--link')
    @$modal_background = $('div.modal--background')
    @$modal_close = $('div.modal--close')
    @init()

  init: ->
    if @$modal_link.length > 0
      @listen()

  listen: ->
    @$modal_link.on 'click', (e) =>
      e.preventDefault()
      $.ajax(url: $(e.currentTarget).attr('href')).done (html) ->
        $('div.modal').find('div.modal--content').html($(html).find('main').html())
        $('div.modal').removeClass('hidden')

    @$modal_background.on 'click', (e) =>
      $('div.modal').addClass('hidden')

    @$modal_close.on 'click', (e) =>
      $('div.modal').addClass('hidden')