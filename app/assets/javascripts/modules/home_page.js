homePage = function () {

  google = document.querySelector('.googleSearch');
  form = document.querySelector('form#f');

  if(google != null)
  {
    google.focus();
    form.addEventListener('submit', submitSearch);
  }


  function submitSearch(event)
  {
    event.preventDefault();
    event.currentTarget.submit();
    google.focus();
    google.value = '';
  }

};
