@GregHome ||= {}

class GregHome.VerifyThePies
  constructor: ->
    @$welcome = $('div#welcome')
    @$start = $('div#start')
    @$play = $('div#play')
    @ingredients = @get_ingredients()
    @$ingredient_1 = $('span#ingredient_1')
    @$ingredient_2 = $('span#ingredient_2')
    @$right = $('div#right')
    @$wrong = $('div#wrong')
    @listen()

  listen: ->
    @$start.on 'click', (e) =>
      @$welcome.addClass('hidden')
      @$play.removeClass('hidden')
      @init_score()
      @bake_pie()

  init_score: ->
    @wrong = 0
    @right = 0
    @start_at = @get_current_time()
    @update_score()
    @listen_keys()

  start_timer: ->
    @baked_at = @get_current_time()

  listen_keys: ->
    $('body').on 'click', 'div.game-button', (e) =>
      $el = $(e.currentTarget)
      @time_taken = @get_current_time() - @baked_at
      @pie_quality = @ingredient_1[0] + @ingredient_2[0]

      console.log 'pie quality: ' + @pie_quality
      console.log 'guessed: ' + $el.data('pie-quality-guess')

      if $el.data('pie-quality-guess') == @pie_quality
        @right = @right + 1
      else
        @wrong = @wrong + 1
      @update_score()
      @bake_pie()

  update_score: ->
    @$right.html(@right)
    @$wrong.html(@wrong)

  bake_pie: ->
    @ingredient_1 = @get_random_ingredient()
    @ingredient_2 = @get_random_ingredient()

    @$ingredient_1.html(@ingredient_1[1])
    @$ingredient_2.html(@ingredient_2[1])

    @start_timer()

  get_current_time: ->
    Math.floor((new Date()).getTime() / 1000)


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