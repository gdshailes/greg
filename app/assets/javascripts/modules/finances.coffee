class GregHome.DiaryEntry
  constructor: ->
    @$new_transaction_button = $('input#new-transaction-button')
    @$new_transaction_form = $('div#new-transaction-form')
    @init()

  init: ->
    if @$new_transaction_button.length > 0
      @listen()

  listen: ->
    @$new_transaction_button.on 'click', (e) =>
      @show_new_transaction_form()

  show_new_transaction_form: ->
    @$new_transaction_form.removeClass('hidden')