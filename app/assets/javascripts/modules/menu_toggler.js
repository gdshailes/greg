menuToggler = function() {
  
  button = document.querySelector('.show-menu');
  menu = document.querySelector('nav.menu');
  
  if(button != null && menu != null)
  {
    button.addEventListener('click', function() { menuToggle(menu, button); });
  };

  function menuToggle(menu, button)
  {
    iconClasses = button.querySelector('i').classList;
    if(menu.classList.contains('show'))
    {
      menu.classList.remove('show');
      iconClasses.remove('fa-arrow-left');
      iconClasses.add('fa-arrow-right');
    }
    else
    {
      menu.classList.add('show');
      iconClasses.remove('fa-arrow-right');
      iconClasses.add('fa-arrow-left');
    }
  }
};
