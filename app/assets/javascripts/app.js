$(function(){
	$('.modal').change(function() {
	    if($(this).val() == "3") {
			$("body").addClass("modal-open");
	    }
	});

	$(".modal-fade-screen, .modal-close").on("click", function() {
		$("body").removeClass("modal-open");
	});

	$(".modal-inner").on("click", function(e) {
		e.stopPropagation();
	});

	$(window).scroll(function() {
	  if ($(this).scrollTop() > 200){ 
	    $('.hero-wrap-js').addClass("smaller");
	  }
	  else{
	    $('.hero-wrap-js').removeClass("smaller");
	  }
	});

	$(window).scroll(function(){
	    if ($(this).scrollTop() > 600) {
	        $(".scrollToTop").addClass("show-scroll");
	    } else {
	        $(".scrollToTop").removeClass("show-scroll");
	    }
	});

	//Click event to scroll to top
	$(".scrollToTop").click(function(){
	    $('html, body').animate({scrollTop : 0},500);
	    return false;
	});
});
	