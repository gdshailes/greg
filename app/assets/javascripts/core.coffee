@GregHome ||= {}

jQuery ->

  new GregHome.Base()
  new GregHome.Ratrace()           if $('body.ratrace').length
  new GregHome.HomePage()          if $('body.greghome').length
  new GregHome.Finances()          if $('body.finances').length
  new GregHome.Decision()          if $('body.decisions').length
  new GregHome.BorisCam()          if $('body.boriscams').length
  new GregHome.VerifyThePieOrNot() if $('body.verify_pie').length
  new GregHome.RatraceCountdown()  if $('.countdown').length
