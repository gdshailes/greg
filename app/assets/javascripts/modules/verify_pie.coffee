@GregHome ||= {}

class GregHome.VerifyThePieOrNot
  constructor: ->
    @$welcome         = $('#welcome')
    @$start           = $('#start')

    @listen()

  listen: ->
    $('body').on 'click', '#start' (event) ->
      @$welcome.addClass('hidden')
      @$start.removeClass('hidden')

