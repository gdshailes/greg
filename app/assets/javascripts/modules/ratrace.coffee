@GregHome ||= {}

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

  listen_intro: ->
    @$intro_title.on 'click', (e) =>
      @intro_toggle()

  listen_more_posts: ->
    $(window).on 'scroll', (e) =>
      @scroll_handler()

    $(document).ajaxComplete (e) =>
      @loading_more = false

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
