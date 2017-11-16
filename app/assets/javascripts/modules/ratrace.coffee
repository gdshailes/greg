class GregHome.Ratrace
  constructor: ->
    @$intro = $('div.intro-para')
    @$intro_title = $('div.intro h1')
    @init()

  init: ->
    if @$intro_title.length > 0
      @listen()

    @update_countdown()
    @start_timer()

  listen: ->
    @$intro_title.on 'click', (e) =>
      @intro_toggle()

  intro_toggle: ->
    if @$intro.hasClass 'collapsed'
      @$intro.removeClass 'collapsed'
    else
      @$intro.addClass 'collapsed'

  start_timer: ->
    @update = setInterval(@update_countdown, 1000)

  update_countdown: ->
    dateNow = Math.floor((new Date()).getTime() / 1000)
    dateRace = Math.floor((new Date(2018,8,8,7,30,0)).getTime() / 1000)

    seconds = dateRace - dateNow

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
