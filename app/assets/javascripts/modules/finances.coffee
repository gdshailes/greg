class GregHome.Finances
  constructor: ->
    @$modal_dialogue = $('div.modal')
    @$modal_background = $('div.modal--background')
    @$new_transaction_link = $('a.new-transaction-link')
    @$new_transaction_form = $('div#new-transaction-form')
    @$edit_transaction_link = $('a.edit-transaction-link')
    @$edit_transaction_form = $('div#edit-transaction-form')
    @$paid_bill_link = $('a.paid-bill-link')
    @init()

  init: ->
    if @$new_transaction_link.length > 0
      @listen()

  listen: ->
    @$new_transaction_link.on 'click', (e) =>
      e.preventDefault()
      @show_new_transaction_form()

    @$edit_transaction_link.on 'click', (e) =>
      e.preventDefault()
      $.ajax(url: $(e.currentTarget).attr('href')).done (html) ->
        @$edit_transaction_form = $('div#edit-transaction-form')
        @$edit_transaction_form.find('div.modal--form').html($(html).find('main'))
        @$edit_transaction_form.removeClass('hidden')

    @$paid_bill_link.on 'click', (e) =>
      e.preventDefault()
      $.ajax(url: $(e.currentTarget).attr('href')).done (html) ->
        @$edit_transaction_form = $('div#edit-transaction-form')
        @$edit_transaction_form.find('div.modal--form').html($(html).find('main'))
        @$edit_transaction_form.removeClass('hidden')

    @$modal_background.on 'click', (e) =>
      @$modal_dialogue.addClass('hidden')

  show_new_transaction_form: ->
    @$new_transaction_form.removeClass('hidden')
