class GregHome.Decision
  constructor: ->
    @$options_list  = $('#options_list')
    @$new_option    = $('#new_option')
    @$add_option    = $('#add_option')
    @$random_choice = $('#random_choice')
    @$result        = $('#result')
    @$decision      = $('#decision')
    @$make_decision = $('#make_decision')
    @init()

  init: ->
      @listen()

  listen: ->
    @$add_option.on 'click', (event) =>
      if @$new_option.val() > ''
        @add_to_options_list(@$new_option.val())

    @$random_choice.on 'click', (event) =>
      @show_random_choice()

  add_to_options_list: ->
    @$options_list
    .append($('<li>')
      .append(@$new_option.val()))
    @$new_option.val('')
    @$new_option.focus()
    @xable_buttons()

  xable_buttons: ->
    @$random_choice.attr("disabled", (@options().length < 2))

  options: ->
    return @$options_list.children('li')

  show_random_choice: ->
    if @options().length > 0
      selected = (Math.floor(Math.random() * @options().length))
      @$decision.text(@$options_list.children('li').toArray()[selected].innerText)
      @$result.removeClass('hidden')
      @$make_decision.addClass('hidden')
