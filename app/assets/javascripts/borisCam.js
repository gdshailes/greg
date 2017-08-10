$('document').ready(function(){

	var i = 1;
	var stopped = false;
	var update = setInterval(nextPic, 3000);

	$('#caption').text('BorisCam - ' + i + ' of ' + pics);

	$('#carousel').css({width:'' + (pics * 640)});

	$('html').keydown(function(e){
		switch(e.which) {
			case 37:
				if(!stopped){ stopStart() };
				prevPic(true);
				break;
			case 39:
				if(!stopped){ stopStart() };
				nextPic(true);
				break;
			default:
				break;
		}
	});

	$('#stopstart').click(function(){
		stopStart();
	})

	$('#slideshow').mouseenter(function(){
		$('.navLink').stop()
		$('.navLink').animate({opacity:0.5}, 500);
	})

	$('#slideshow').mouseleave(function(){
		$('.navLink').stop()
		$('.navLink').animate({opacity:0.0}, 500);
	})

	$('.navLink').mouseenter(function(){
		$(this).stop();
		$(this).animate({opacity:0.9}, 500);
	})

	$('.navLink').mouseleave(function(){
		$(this).stop();
		$(this).animate({opacity:0.5}, 250);
	})

	$('#prev').click(function(e){
		if(!stopped){ stopStart() };
		e.preventDefault();
		prevPic(false);
	})

	$('.next').click(function(e){
		if(!stopped){ stopStart() };
		e.preventDefault();
		nextPic(false);
	})

	function prevPic(noAnimation) {
		i--;
		if(i == 0) { i = pics; }
		moveCarousel(noAnimation);
	}

	function nextPic(noAnimation) {
		i++;
		if(i > pics) { i = 1; }
		moveCarousel(noAnimation);
	}

	function moveCarousel(noAnimation) {
		$('#carousel').stop();
		move = {left: '' + (i - 1) * -640 + 'px'};
		if(noAnimation)
		{
			$('#carousel').css(move);
		}
		else
		{
			$('#carousel').animate(move, 500);
		}
		$('#caption').text('BorisCam - ' + i + ' of ' + pics);
	}

	function stopStart()
	{
		stopped = !stopped;
		if(stopped)
		{
			$('#stopstart').text("Click to START slideshow");
			clearInterval(update);
		}
		else
		{
			$('#stopstart').text("Click to STOP slideshow");
			nextPic(false);
			update = setInterval(nextPic, 3000);
		}
	}

	$('#slideshow').on('swipeleft', function(){
		if(!stopped){ stopStart() };
		nextPic();
	});

	$('#slideshow').on('swiperight', function(){
		if(!stopped){ stopStart() };
		prevPic();
	});
});
