@GregHome ||= {}

class GregHome.VerifyThePies
  constructor: ->
    @init()
    @listen()

  init: ->
    @target = 100
    @max_failures = 3
    @get_ingredients()

    @$border = $('body')
    @$paper = $('div#paper')

    @$welcome = $('div#welcome')
    @$start = $('div#start')

    @$get_ready = $('div#get-ready')

    @$play = $('div#play')
    @$too_slow = $('div#too-slow')
    @$new_best = $('div#new-best')
    @$wrong_guess = $('div#wrong-guess')
    @$bad_ingredient = $('div#wrong-guess span')
    @$game_buttons = $('div#game-buttons')
    @$pie_name = $('div#pie-name')
    @$ingredient_1 = $('span#ingredient_1')
    @$ingredient_2 = $('span#ingredient_2')
    @$score_time = $('div#score-time')
    @$score_pies = $('div#score-pies')
    @$score_tries = $('div#score-tries')
    @$score_best = $('div#score-best')
    @$score_fails = $('div#score-fails')
    @$score_mean = $('div#score-mean')

    @$results = $('div#results')
    @$results_best_pie = $('li#results-best-pie')
    @$best_pie = $('span#best-pie')
    @$results_end_reason = $('span#results-end-reason')
    @$win = $('li#win')
    @$retry = $('div#retry')

  listen: ->
    @$start.on 'click', (e) =>
      @get_ready()

    $('body').on 'click', 'div#game-buttons.enabled span ', (e) =>
      @identify_pie($(e.currentTarget).data('pie-quality-guess'))

    $('body').on 'click', 'div#stop', (e) =>
      @end_shift()

    $('body').on 'click', 'div#retry', (e) =>
      @restart()

  get_ready: ->
    _this = @
    @$border.addClass('yellow')
    @$paper.addClass('yellow')
    @$welcome.addClass('hidden')
    @$get_ready.removeClass('hidden')

    @update = setTimeout(->
      _this.start_shift()
    , 2000)

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

  bake_pie: ->
    _this = @

    @ingredient_1 = @get_ingredient()
    @ingredient_2 = @get_ingredient()
    @pie_quality = @ingredient_1[0] + @ingredient_2[0]

    @$ingredient_1.html(@ingredient_1[1])
    @$ingredient_2.html(@ingredient_2[1])

    @baked_at = @get_current_time()

    @timeout = setTimeout(->
      _this.too_slow()
    , 2500)

  get_ingredient: ->
    index = Math.floor(Math.random() * @ingredients.length)
    @ingredients[index]

  get_current_time: ->
    (new Date()).getTime() / 1000

  too_slow: ->
    @identify_pie(-1)

  identify_pie: (quality_guess) ->
    _this = @
    time = @get_current_time() - @baked_at
    clearTimeout(@timeout)
    @$game_buttons.removeClass('enabled')

    if quality_guess == @pie_quality
      @correct_guess(time)
    else
      @incorrect_guess(quality_guess == -1)

    @update_score(time)

    @update = setTimeout(->
      _this.next_pie()
    , 1250)

  correct_guess: (time) ->
    @right += 1
    @$border.addClass('green')
    if @best_time == 0 || time < @best_time
      @$new_best.removeClass('hidden')
      @$best_pie.html(@$pie_name.text())
      @best_time = time

  incorrect_guess: (too_slow) ->
      @wrong = @wrong + 1
      @$border.addClass('red')
      if too_slow
        @$too_slow.removeClass('hidden')
      else
        if @pie_quality < 2
          @$bad_ingredient.html(@ingredient_1[1]) if @ingredient_1[0] == 0
          @$bad_ingredient.html(@ingredient_2[1]) if @ingredient_2[0] == 0
          @$wrong_guess.removeClass('hidden')


  update_score: (time) ->
    @$score_time.html(parseFloat(time).toFixed(2))
    @$score_best.html(parseFloat(@best_time).toFixed(2))
    @$score_pies.html(@right)
    @$score_tries.html(@right + @wrong)
    @$score_fails.html(@wrong)
    @$score_mean.html(@mean_time())

  next_pie: ->
    clearTimeout(@update)
    @$too_slow.addClass('hidden')
    @$wrong_guess.addClass('hidden')
    @$new_best.addClass('hidden')
    @$border.removeClass('red')
    @$border.removeClass('green')
    @$game_buttons.addClass('enabled')

    @fired = @wrong >= @max_failures
    @succeeded = @right >= @target

    if @fired || @succeeded
      @end_shift()
    else
      @bake_pie()

  end_shift: ->
    @$too_slow.addClass('hidden')
    @$wrong_guess.addClass('hidden')
    @$border.removeClass('red')
    @$border.removeClass('green')
    clearTimeout(@timeout)
    @$play.addClass('hidden')
    @$retry.html('Rats.')
    @$results.removeClass('hidden')
    @$results_end_reason.html('quit')
    @$results_end_reason.html('were fired') if @fired
    @$results_best_pie.removeClass('hidden') if @right > 0

    if @succeeded
      @$results_end_reason.html('finished your shift')
      @$win.removeClass('hidden')
      @$retry.html('Yay!')

    $('span#results-total-time').html(parseFloat(@total_time()).toFixed(2))
    $('span#results-right').html(@right)
    $('span#results-best-time').html(parseFloat(@best_time).toFixed(2))
    $('span#results-mean').html(@mean_time())

  restart: ->
    @init_score()
    @$paper.removeClass('yellow')
    @$border.removeClass('yellow')
    @$border.removeClass('red')
    @$border.removeClass('green')

    @$welcome.removeClass('hidden')

    @$play.addClass('hidden')
    @$results.addClass('hidden')
    @$win.addClass('hidden')

  mean_time: ->
    if @right > 0
      parseFloat(@total_time() / @right).toFixed(6)
    else
      ''

  total_time: ->
    @get_current_time() - @start_time

  get_ingredients: ->
    _this = @
    $.ajax(url: "/verify_the_pie/ingredients.json").done (ingredients) ->
      _this.ingredients = ingredients
