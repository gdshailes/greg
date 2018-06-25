class GregHome.Finances
  constructor: ->
    @$modal_link = $('a.modal--link')
    @$modal_background = $('div.modal--background')
    @init()

  init: ->
    if @$modal_link.length > 0
      @listen()

  listen: ->
    @$modal_link.on 'click', (e) =>
      e.preventDefault()
      $.ajax(url: $(e.currentTarget).attr('href')).done (html) ->
        $('div.modal').find('div.modal--form').html($(html).find('main'))
        $('div.modal').removeClass('hidden')

    @$modal_background.on 'click', (e) =>
      $('div.modal').addClass('hidden')