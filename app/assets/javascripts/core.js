
window.onload = function() {
  
  body_classes = document.querySelector('body').classList

  menuToggler.call();

  if(body_classes.contains('greghome')) {
    new GregHome.HomePage();
  }
  if(body_classes.contains('ratrace')) {
    new GregHome.Ratrace();
  }
  if(body_classes.contains('decisions')) {
    new GregHome.Decision();
  }
  if(body_classes.contains('boriscam')) {
    new GregHome.BorisCam();
  }
  if(body_classes.contains('verify_the_pies')) {
    new GregHome.VerifyThePies();
  }
  confirmation.call();
}
