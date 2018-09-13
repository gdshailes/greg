@GregHome ||= {}

class GregHome.BorisCam
  constructor: ->
    @init()

  init: ->
    _this = @
    @i = 1
    @pics = 20
    @stopped = false
    @update = setInterval(->
      _this.nextSlide(_this)
    , 3000)

    $('#caption').text('BorisCam - ' + @i + ' of ' + @pics)
    $('#carousel').css({width:'' + (@pics * 640)})

    @listen()

  listen: ->
    $('html').on 'keydown', (event) =>
      if event.which == 37
        @stopStart() unless @stopped
        @prevPic(true)
      else
        if event.which == 39
          @stopStart() unless @stopped
          @nextPic(@, true)

    $('#stopstart').on 'click', (event) =>
      @stopStart()

    $('#prev').on 'click', (event) =>
      @stopStart() unless @stopped
      event.preventDefault()
      @prevPic(false)

    $('.next').on 'click', (event) =>
      @stopStart() unless @stopped
      event.preventDefault()
      @nextPic(@, false)

    $('#slideshow').on 'swipeleft', =>
      @stopStart() unless @stopped
      @nextPic(@, false)

    $('#slideshow').on 'swiperight', =>
      @stopStart() unless @stopped
      @prevPic(false)

  stopStart: ->
    @stopped = !@stopped;
    if @stopped
      $('#stopstart').text("Click to START slideshow")
      clearInterval(@update)
    else
      $('#stopstart').text("Click to STOP slideshow")
      _this = @
      @update = setInterval(->
        _this.nextSlide(_this)
      , 3000)

  nextSlide: (_this, noAnimation) ->
    _this.i++
    _this.i = 1 if _this.i > _this.pics
    _this.moveCarousel(noAnimation)

  nextPic: (noAnimation) ->
    @i++
    @i = 1 if @i > @pics
    @moveCarousel(noAnimation)

  prevPic: (noAnimation) ->
    @i--
    @i = @pics if @i == 0
    @moveCarousel(noAnimation)

  moveCarousel: (noAnimation) ->
    $('#carousel').stop()
    move = {left: '' + (@i - 1) * -640 + 'px'}
    if noAnimation
      $('#carousel').css(move)
    else
      $('#carousel').animate(move, 250)
    $('#caption').text('BorisCam - ' + @i + ' of ' + @pics)
