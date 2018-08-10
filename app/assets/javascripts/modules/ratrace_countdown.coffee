@GregHome ||= {}

class GregHome.RatraceCountdown
  constructor: ->
    @init()

  init: ->
    @update_countdown()
    @start_timer()

  start_timer: ->
    @update = setInterval(@update_countdown, 1000)

  update_countdown: ->
    dateNow = Math.floor((new Date()).getTime() / 1000)
    dateRace = Math.floor((new Date(2018,8,8,7,30,0)).getTime() / 1000)

    seconds = dateRace - dateNow

    # weeks = Math.floor(seconds / 604800)
    # seconds = seconds - (weeks * 604800)

    days = Math.floor(seconds / 86400)
    seconds = seconds - (days * 86400)

    hours = Math.floor(seconds / 3600)
    seconds = seconds - (hours * 3600)

    minutes = Math.floor(seconds / 60)
    seconds = Math.floor(seconds - (minutes * 60))

    # $('.countdown .weeks').text(weeks)
    $('.countdown .days').text(days)
    $('.countdown .hours').text(hours)
    $('.countdown .minutes').text(minutes)
    $('.countdown .seconds').text(seconds)
