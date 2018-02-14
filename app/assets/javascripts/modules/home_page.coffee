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
      @focus_on_search()

    $('a').on 'click', (event) =>
      @focus_on_search()

  focus_on_search: ->
    @$google.focus()
    @$google.select()
