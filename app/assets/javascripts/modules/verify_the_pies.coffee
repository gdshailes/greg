@GregHome ||= {}

class GregHome.VerifyThePies
  constructor: ->
    @$border = $('body')
    @$paper = $('div#paper')
    @$welcome = $('div#welcome')
    @$start = $('div#start')
    @$get_ready = $('div#get-ready')
    @$play = $('div#play')
    @$new_best = $('div#new-best')
    @$game_buttons = $('div#game-buttons')
    @ingredients = @get_ingredients()
    @$ingredient_1 = $('span#ingredient_1')
    @$ingredient_2 = $('span#ingredient_2')
    @$results_time = $('div#results-time')
    @$results_pies = $('div#results-pies')
    @$results_best = $('div#results-best')
    @$results_fails = $('div#results-fails')
    @$results_mean = $('div#results-mean')

    @listen()

  restart: ->
    @$border.removeClass('yellow')
    @$border.removeClass('green')
    @$border.removeClass('red')
    @$paper.removeClass('yellow')
    @$welcome.removeClass('hidden')
    @$play.addClass('hidden')
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
      @$game_buttons.removeClass('enabled')
      $el = $(e.currentTarget)
      @pie_quality = @ingredient_1[0] + @ingredient_2[0]
      if $el.data('pie-quality-guess') == @pie_quality
        @right = @right + 1
        @$border.addClass('green')
        time = @get_current_time() - @baked_at

        if @best_time == 0
          @best_time = time
        else
          if time < @best_time
            @$new_best.removeClass('hidden')
            @best_time = time
      else
        @wrong = @wrong + 1
        @$border.addClass('red')
      @update_score()

      _this = @
      @update = setTimeout(->
        _this.next_pie()
      , 1250)

    $('body').on 'click', 'div#stop', (e) =>
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

    @$results_time.html('')
    @$results_best.html('')
    @$results_pies.html('')
    @$results_fails.html('')
    @$results_mean.html('')

  next_pie: ->
    clearTimeout(@update)
    @$border.removeClass('red')
    @$border.removeClass('green')
    @$game_buttons.addClass('enabled')
    @$new_best.addClass('hidden')
    @bake_pie()

  update_score: ->
    total_time = @get_current_time() - @start_time
    @$results_time.html(total_time)
    @$results_best.html(@best_time)
    @$results_pies.html(@right + @wrong)
    @$results_fails.html(@wrong)
    if @right > 0
      @$results_mean.html(total_time / @right)
    else
      @$results_mean.html('')

  bake_pie: ->
    @ingredient_1 = @get_random_ingredient()
    @ingredient_2 = @get_random_ingredient()

    @$ingredient_1.html(@ingredient_1[1])
    @$ingredient_2.html(@ingredient_2[1])

    @baked_at = @get_current_time()

  get_current_time: ->
    (new Date()).getTime() / 1000

  get_random_ingredient: ->
    index = Math.floor(Math.random() * @ingredients.length)
    @ingredients[index]

  get_ingredients: ->
    [
      [1, "STEAK"],
      [1, "KIDNEY"],
      [1, "BROCOLLI"],
      [1, "BEEF"],
      [1, "CHICKEN"],
      [1, "MUSHROOM"],
      [1, "CHEESE"],
      [1, "ONION"],
      [1, "TOMATO"],
      [1, "PULLED PORK"],
      [1, "LAMB"],
      [1, "SWEETCORN"],
      [1, "PIGEON"],
      [1, "VENISON"],
      [1, "POTATO"],
      [1, "CARROT"],
      [1, "SWEETCORN"],
      [1, "LEEK"],
      [1, "'MEAT'"],
      [1, "EGG"],
      [1, "MINCE"],
      [1, "BACON"],
      [1, "CURRY"],
      [1, "CHICKEN TIKKA"],
      [1, "RABBIT"],
      [1, "MACKEREL"],
      [1, "TURKEY"],
      [1, "HAM"],

      [0, "TOENAIL"],
      [0, "CARDBOARD"],
      [0, "TYRE"],
      [0, "RAT POISON"],
      [0, "GLASS"],
      [0, "VOMIT"],
      [0, "NOVICHOK"],
      [0, "CEMENT"],
      [0, "PETROL"],
      [0, "COFFEE MUG"],
      [0, "MOTORCYCLIST"],
      [0, "DISAPPOINTMENT"],
      [0, "LIBRARY BOOK"],
      [0, "FIRE"],
      [0, "BILE"],
      [0, "PLASTIC"],
      [0, "LAVA"],
      [0, "GUNPOWDER"]

    ]