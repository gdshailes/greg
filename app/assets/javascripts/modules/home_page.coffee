class GregHome.HomePage
  constructor: ->
    @$google = $('.googleSearch')
    @init()

  init: ->
    if @$google.length > 0
      @$google.focus()
