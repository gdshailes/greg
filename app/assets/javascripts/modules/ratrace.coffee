class GregHome.Ratrace
  constructor: ->
    @$countdown = $('span#countdown')

  init: ->
    if @$countdown.length > 0
      @start_timer()

  start_timer: ->
    @update = setInterval(update_countdown, 1000)

  update_countdown: ->
    @$countdown.text('wibble')