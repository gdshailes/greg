confirmation = function() {
  $confirm_message = $('div.confirm--content span#message');
  $confirm_background = $('div.confirm--background');
  $confirm_close = $('div.confirm--buttons a#cancel');
  $confirm_button = $('div.confirm--buttons a#confirm');
  $confirmation_link = $('a.confirmation');

  if($confirmation_link.length > 0)
  {
    $confirmation_link.on('click', showConfirmation);
    $confirm_background.on('click', hideConfirmation);
    $confirm_close.on('click', hideConfirmation);
    $confirm_button.on('click', function(e){ alert(e);} );
  };

  function hideConfirmation(e) {
    $('div.confirm').addClass('hidden');
  };

  function showConfirmation(e)
  {
    e.preventDefault();
    link = $(e.currentTarget);
    $confirm_message.html(link.data('confirmation-message'));
    $confirm_button.attr('href', link.attr('data-href'));
    $confirm_button.attr('target', link.attr('target'));
    $confirm_button.attr('data-method', link.attr('data-method'));
    $('div.confirm').removeClass('hidden');
  };
};
