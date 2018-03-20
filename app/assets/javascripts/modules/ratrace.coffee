class GregHome.Ratrace
  constructor: ->
    @$intro = $('div.intro')
    @$intro_title = $('a.expander')
    @$latest_post_id = $('input[name=post_id]')
    @loading_more = false

    @init()

  init: ->
    if @$intro_title.length > 0
      @listen_intro()

    if @$latest_post_id.length > 0
      @latest_post_id = @$latest_post_id.get(-1).value
      @loading_more = false
      @listen_more_posts()

    @update_countdown()
    @start_timer()

  listen_intro: ->
    @$intro_title.on 'click', (e) =>
      @intro_toggle()

  listen_more_posts: ->
    $(window).on 'scroll', (e) =>
      @scroll_handler()

    $(document).ajaxComplete (e) =>
      @loading_more = false
      console.log 'ajaxComplete'

  intro_toggle: ->
    if @$intro.hasClass 'collapsed'
      @$intro.removeClass 'collapsed'
    else
      @$intro.addClass 'collapsed'

  scroll_handler: ->
    if @loading_more == false
      if $(window).scrollTop() + $(window).height() > $(document).height() - 10
        @loading_more = true
        @load_next_post()

  load_next_post: ->
    $.ajax(
      url: '/ratrace/posts/' + @latest_post_id + '/get_next'
    ).done( (posts) =>
      $('#posts').append(posts)
      @latest_post_id = $('input[name=post_id]').get(-1).value
      @loading_more = false
    );

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
