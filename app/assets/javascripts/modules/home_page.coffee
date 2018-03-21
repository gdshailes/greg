class GregHome.HomePage
  constructor: ->
    @$google = $('.googleSearch')
    @$form = $('form#f')
    @init()

  init: ->
    if @$google.length > 0
      @$google.focus()
      @listen()

  listen: ->
    @$form.on 'submit', (event) =>
      event.preventDefault()
      event.currentTarget.submit()
      @focus_on_search()

    $('a').on 'click', (event) =>
      @focus_on_search()

  focus_on_search: ->
    @$google.focus()
    @$google.val('')
