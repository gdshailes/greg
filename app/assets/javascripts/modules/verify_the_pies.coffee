@GregHome ||= {}

class GregHome.VerifyThePies
  constructor: ->
    @$welcome = $('div#welcome')
    @$start   = $('div#start')

    @listen()

  listen: ->
    $('body').on 'click', 'div#start', (event) =>
      @$welcome.addClass('hidden')
      @$start.removeClass('hidden')
