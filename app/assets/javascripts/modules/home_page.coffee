class GregHome.HomePage
  constructor: ->
    @$google = $('.googleSearch')
    @$submit = $('.GoogleButton')
    @init()

  init: ->
    if @$google.length > 0
      @$google.focus()
      @listen()

  listen: ->
    @$submit.on 'click', (event) =>
      @$google.focus()
      @$google.select()
