@GregHome ||= {}

jQuery ->

  new GregHome.DiaryEntry()       if $('body.diary_entry').length
  new GregHome.Ratrace()          if $('body.ratrace').length
  new GregHome.HomePage()         if $('body.greghome').length
  new GregHome.Finances()         if $('body.finances').length
  new GregHome.Decision()         if $('body.decisions').length
  new GregHome.BorisCam()         if $('body.boriscams').length
  new GregHome.RatraceCountdown() if $('.countdown').length
