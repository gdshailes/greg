@GregHome ||= {}

class GregHome.VerifyThePies
  constructor: ->
    @init()
    @listen()

  init: ->
    @$border = $('body')
    @$paper = $('div#paper')
    @$welcome = $('div#welcome')
    @$start = $('div#start')
    @$get_ready = $('div#get-ready')
    @$too_slow = $('div#too-slow')
    @$play = $('div#play')
    @$new_best = $('div#new-best')
    @$game_buttons = $('div#game-buttons')
    @$ingredient_1 = $('span#ingredient_1')
    @$ingredient_2 = $('span#ingredient_2')
    @$score_time = $('div#score-time')
    @$score_pies = $('div#score-pies')
    @$score_tries = $('div#score-tries')
    @$score_best = $('div#score-best')
    @$score_fails = $('div#score-fails')
    @$score_mean = $('div#score-mean')
    @$results = $('div#results')
    @$results_end_reason = $('span#results-end-reason')
    @$retry = $('div#retry')
    @$win = $('div#win')
    @target = 4
    @get_ingredients()

  restart: ->
    @$border.removeClass('yellow')
    @$border.removeClass('green')
    @$border.removeClass('red')
    @$paper.removeClass('yellow')
    @$welcome.removeClass('hidden')
    @$play.addClass('hidden')
    @$results.addClass('hidden')
    @init_score()

  listen: ->
    @$start.on 'click', (e) =>
      @$border.addClass('yellow')
      @$paper.addClass('yellow')
      @$welcome.addClass('hidden')
      @$get_ready.removeClass('hidden')

      _this = @
      @update = setTimeout(->
        _this.start_shift()
      , 3000)

    $('body').on 'click', 'div#game-buttons.enabled span ', (e) =>
      _this = @
      clearTimeout(@timeout)
      @$game_buttons.removeClass('enabled')
      $el = $(e.currentTarget)
      @pie_quality = @ingredient_1[0] + @ingredient_2[0]
      time = @get_current_time() - @baked_at

      if $el.data('pie-quality-guess') == @pie_quality
        @right = @right + 1
        @$border.addClass('green')
        if @best_time == 0
          @best_time = time
        else
          if time < @best_time
            @$new_best.removeClass('hidden')
            @best_time = time
        if @right >= @target
          setTimeout(->
            _this.end_shift()
          , 1250)
          return
      else
        @wrong = @wrong + 1
        @$border.addClass('red')

      @update_score(time)

      @update = setTimeout(->
        _this.next_pie()
      , 1250)

    $('body').on 'click', 'div#stop', (e) =>
      @end_shift()

    $('body').on 'click', 'div#retry', (e) =>
      @restart()

  start_shift: ->
    @$get_ready.addClass('hidden')
    @$play.removeClass('hidden')
    @init_score()
    @bake_pie()

  init_score: ->
    @start_time = @get_current_time()
    @wrong = 0
    @right = 0
    @best_time = 0

    @$score_time.html('')
    @$score_best.html('')
    @$score_pies.html('')
    @$score_tries.html('')
    @$score_fails.html('')
    @$score_mean.html('')

  next_pie: ->
    clearTimeout(@update)
    @$too_slow.addClass('hidden')
    @$border.removeClass('red')
    @$border.removeClass('green')
    @$game_buttons.addClass('enabled')

    if @wrong >= 3
      @end_shift()
    else
      @$new_best.addClass('hidden')
      @bake_pie()

  update_score: (time) ->
    @$score_time.html(parseFloat(time).toFixed(2))
    @$score_best.html(parseFloat(@best_time).toFixed(2))
    @$score_pies.html(@right)
    @$score_tries.html(@right + @wrong)
    @$score_fails.html(@wrong)
    @$score_mean.html(@mean_time())

  mean_time: ->
    if @right > 0
      parseFloat(@total_time() / @right).toFixed(6)
    else
      ''

  total_time: ->
    @get_current_time() - @start_time

  bake_pie: ->
    @ingredient_1 = @get_random_ingredient()
    @ingredient_2 = @get_random_ingredient()

    @$ingredient_1.html(@ingredient_1[1])
    @$ingredient_2.html(@ingredient_2[1])

    @baked_at = @get_current_time()

    _this = @
    @timeout = setTimeout(->
      _this.too_slow()
    , 2500)

  too_slow: ->
    @$game_buttons.removeClass('enabled')
    @$too_slow.removeClass('hidden')
    @$border.addClass('red')
    @wrong = @wrong + 1
    @update_score(2)

    _this = @
    @update = setTimeout(->
      _this.next_pie()
    , 1250)

  end_shift: ->
    @$too_slow.addClass('hidden')
    @$border.removeClass('red')
    @$border.removeClass('green')
    clearTimeout(@timeout)
    @$play.addClass('hidden')

    @$results.removeClass('hidden')
    @$results_end_reason.html('quit')
    @$results_end_reason.html('finished your shift') if @right >= @target
    @$results_end_reason.html('were fired') if @wrong >= 3

    @$retry.html('Rats.')
    @$retry.html('Yay!') if @right >= @target

    $('span#results-total-time').html(parseFloat(@total_time()).toFixed(2))
    $('span#results-right').html(@right)
    $('span#results-best-time').html(parseFloat(@best_time).toFixed(2))
    $('span#results-mean').html(@mean_time())

  get_current_time: ->
    (new Date()).getTime() / 1000

  get_random_ingredient: ->
    index = Math.floor(Math.random() * @ingredients.length)
    @ingredients[index]

  get_ingredients: ->
    _this = @
    $.ajax(url: "/verify_the_pie/ingredients.json").done (ingredients) ->
      _this.ingredients = ingredients
