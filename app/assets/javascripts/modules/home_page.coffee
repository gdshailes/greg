@GregHome ||= {}

class GregHome.HomePage
  constructor: ->
    @$google = $('.googleSearch')
    @$form = $('form#f')
    @$body = $('body')
    @init()

  init: ->
    if @$google.length > 0
      @$google.focus()
      @listen_submit()
      @listen_menu()

    if @$body.length > 0
      @listen_keys()

  listen_submit: ->
    @$form.on 'submit', (event) =>
      event.preventDefault()
      event.currentTarget.submit()
      @focus_on_search()

  listen_menu: ->
    $nav = $('nav')
    $clone = $nav.clone();
    $nav.replaceWith($clone);
    $('a').on 'click', (event) =>
      $(event.currentTarget).blur()
      @focus_on_search()

  listen_keys: ->
    @$body.on 'keypress', (event) =>
      element = $(event.currentTarget).val()
      input_char = if event.which then event.which else event.keyCode
      if (input_char > 31)
        @listen_menu()
        @$google.focus()

  focus_on_search: ->
    @$google.trigger('click')
    @$google.focus()
    @$google.val('')
