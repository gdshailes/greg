class GregHome.Ratrace
  constructor: ->
    @update_countdown()
    @start_timer()

  start_timer: ->
    @update = setInterval(@update_countdown, 1000)

  update_countdown: ->
    dateNow = new Date()
    dateRace = new Date(2018,9,8,7,30,0)

    seconds = Math.floor(dateRace - dateNow) / 1000

    weeks = Math.floor(seconds / 604800) # seconds in a week
    seconds = seconds - (weeks * 604800)

    days = Math.floor(seconds / 86400) # seconds in a day
    seconds = seconds - (days * 86400)

    hours = Math.floor(seconds / 3600) # seconds in an hour
    seconds = seconds - (hours * 3600)

    minutes = Math.floor(seconds / 60) # seconds in a minute
    seconds = Math.floor(seconds - (minutes * 60))

    $('.countdown .weeks').text(weeks)
    $('.countdown .days').text(days)
    $('.countdown .hours').text(hours)
    $('.countdown .minutes').text(minutes)
    $('.countdown .seconds').text(seconds)
