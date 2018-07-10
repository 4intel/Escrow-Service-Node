$(document).ready(function(){
	// 메뉴가 동적으로 만들어 질 경우 메뉴가 만들어 지기 전에 호출 되어서
	// 적용 되지 않을 수 있다. 그런 경우는 동적으로 호출하는 것이 맞다.
	// mContent_InitSelectMenu();
});

function mContent_InitSelectMenu()
{
	// 메뉴가 동적으로 만들어 질 경우 , 만들어 질때 마다 호출해 줘야 한다.
	//--------------상단 드랍메뉴

	var $slideMenuArea = $(".sub-top >.select-area");
	var $slideMenuTitle = $slideMenuArea.find(".controll >.select-menu");
	var $slideMenuBox = $slideMenuArea.find(".select-box >ul");

	var menuHt = $slideMenuBox.find("li").outerHeight();	
	var menuNum = $slideMenuBox.find("li").size();
	
	$slideMenuTitle.on("click",function(e){
		e.preventDefault();

		$menuArea = $(this);

		if($menuArea.hasClass("on")){
			$menuArea.find(".bt").removeClass("on")
			$menuArea.removeClass("on");
			$slideMenuBox.stop().animate({"height":0}, {
				duration:300, 
				easing:'easeOutCubic',
				complete:function(){
					$slideMenuArea.find(".select-box").css({"display":"none"});
				}
			});

		}else{
			var moveHeight = menuHt*menuNum;
			$menuArea.find(".bt").addClass("on");
			$menuArea.addClass("on");
			$slideMenuArea.find(".select-box").css({"display":"block"})
			$slideMenuBox.css({"height":0}).stop().animate({"height":moveHeight}, {duration:300, easing:'easeOutCubic'});
		}

	});

	//--------------list openbox 모두펼쳐짐, class="open-box" 
	
	var $contentsList = $("#content").find(".open-box");
	var $contentsListTit = $contentsList.find(".open-menu")
	
	$contentsListTit.on("click",function(e){
		e.preventDefault();
		var $btn = $(this).find(".bt-close");
		var $list = $(this).parent(".open-box");

		if($list.hasClass("opened")){
			//닫음
			$list.removeClass("opened");
			$list.find(".open-menu").removeClass("on");
			$list.find(".open-cont").css({"display":"none"});
			$btn.removeClass("on");
		}
		else{			
			$list.addClass("opened");
			$list.find(".open-cont").css({"display":"block"});
			$list.find(".open-menu").addClass("on");
		
			$btn.addClass("on");
			
		}
	});

	//--------------list openbox 하나만 펼쳐짐, class="open-box1" 
	
	var $contOneList = $("#content").find(".open-box1");
	var $contOneListTit = $contOneList.find(".open-menu")
	
	$contOneListTit.on("click",function(e){
		e.preventDefault();
		var $btn = $(this).find(".bt-close");
		var $list = $(this).parent(".open-box1");

		if($list.hasClass("opened")){
			//닫음
			$list.removeClass("opened");
			$list.find(".open-menu").removeClass("on");
			$list.find(".open-cont").css({"display":"none"});
			$btn.removeClass("on");
		}
		else{
			//열기
			$contOneList.removeClass("opened");
			$contOneList.find(".open-cont").css({"display":"none"});
			$contOneListTit.removeClass("on");
			$contOneList.find(".bt-close").removeClass("on");
			

			$list.addClass("opened");
			$list.find(".open-cont").css({"display":"block"});
			$list.find(".open-menu").addClass("on");
		
			$btn.addClass("on");			
		}
	});
	
	//첫번째 열림
	var $initContOne = $contOneList.eq(0).find(".open-menu");
	$initContOne.trigger("click");


 //----------------하단Tab
	/*var $tabMenu = $(".sub-top").find($(".sub-menu"));
	var $tabMenuList = $tabMenu.find("ul >li");
	if($tabMenu){
		$tabMenuList.on("click",function(e){
			e.preventDefault();
			$tabMenuList.removeClass("on");
			$(this).addClass("on");
		});
	};*/



	//------------ hotel / reservation open/close

	/*var $reservation = $("#content").find(".cscenter-box");
	var $reservationCont = $("#content").find(".cscenter-box-open");

	$reservation.find("p:last").on("click",function(e){
		e.preventDefault();
		
		if($(this).hasClass("on")){
			$(this).removeClass("on");
			$(this).find("em").removeClass("on");
			$(this).parent().next().css({"display":"none"});
		}else{
			
			$(this).addClass("on");
			$(this).find("em").addClass("on");
			$(this).parent().next().css({"display":"block"});
		}
	});*/


	$(".reserve-benifit-tit").find(">a").on({
		click:function(e){
			e.preventDefault();
			var $parent = $(this).parents(".reserve-benifit-area");
			if($parent.hasClass("on")) $parent.removeClass("on");
			else  $parent.addClass("on");
		}
	});


	//------------------ show more content
	$(".tour-view-area").each(function(){
		var $content = $(this).find(".tour-cont>span");
		var $morebtn = $(this).find(".tour-more");
		
		($content.outerHeight(true)<=80) ? $morebtn.css({"display":"none"}) : $morebtn.css({"display":"block"});
	});

	$(".tour-more").find(">a").on({
		click:function(e){
			e.preventDefault();
			var $morebtn =  $(this).parent(".tour-more");			
			var $content = $morebtn.prev(".tour-cont");
			
			if($morebtn.hasClass("on")){
				$content.css({"height":80,"display":"-webkit-box"});
				$morebtn.removeClass("on");
				$(this).text("[더보기]");
			}
			else{
				$morebtn.addClass("on");
				$content.css({"display":"block","height":"auto"});
			//	$morebtn.css({"display":"none"});
				$(this).text("[접기]");
			}
		}
	});

	$(window).resize(function(){
		$(".tour-view-area").each(function(){
			var $content = $(this).find(".tour-cont>span");
			var $morebtn = $(this).find(".tour-more");
			
			if($content.outerHeight(true)<=80){
				$morebtn.css({"display":"none"}) ;
			}
			else{
				$morebtn.css({"display":"block"}) ;
			}
		});
	});
	
	//--------------footer clubPlatinum 메뉴
	var $clubPlatinum = $(".club-platinum");


	var $clubPlatinumList = $clubPlatinum.find(".sub-menu02 li");	
	$clubPlatinumList.on("click",function(e){	
		e.preventDefault();
		
		index = $(this).index();
		if(index ==0){
			$clubPlatinum.find(".platinum").css("display","block");
			$clubPlatinum.find(".classic").css("display","none");
		}else{
			$clubPlatinum.find(".platinum").css("display","none");
			$clubPlatinum.find(".classic").css("display","block");
		}

		$clubPlatinumList.removeClass("on");
		$(this).addClass("on")
	
	});
}

	




