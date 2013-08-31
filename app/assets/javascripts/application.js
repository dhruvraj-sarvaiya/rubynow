// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(document).ready(function(){
	//alert('page load');

	if($("#job_account_options_1").is(":checked")){
			$("#loginForm").show();
			$("#newAccountForm").hide();
		} else {
			$("#loginForm").hide();
			$("#newAccountForm").show();	
		}
	
	$("#job_account_options_1").change(function () {
		//alert($("#job_account_options_1":checked).length);
		if($(this).is(":checked")){
			$("#loginForm").show();
			$("#newAccountForm").hide();
		} else {
			$("#loginForm").hide();
			$("#newAccountForm").show();	
		}
	});

	$("#job_account_options_2").change(function () {
		//alert($("#job_account_options_1":checked).length);
		if($(this).is(":checked")){
			$("#loginForm").hide();
			$("#newAccountForm").show();	
		} else {
			$("#loginForm").show();
			$("#newAccountForm").hide();
		}
	});

	$(".label-radio").click(function(){
		$(".label-radio").removeClass('label-radio-check');
		$(this).addClass('label-radio-check');
	});



	$("#jobpost_post_type_2").change(function () {
		alert('Premium');
		if($(this).is(":checked")){
			alert('Premium');
			$("#jobpost_post_type_1").removeAttr("checked");
			$("#jobpost_post_type_1").prop('checked', false);
			$(this).attr("checked",true);
			$(this).attr("checked","checked");
			$(this).prop("checked",true);
		}
	});

	$("#jobpost_post_type_1").change(function () {
		alert('Standard');		
		if($(this).is(":checked")){	
			
			$("#jobpost_post_type_2").removeAttr("checked");
			$("#jobpost_post_type_2").prop('checked', false);
			$(this).attr("checked",true);
			$(this).attr("checked","checked");
			$(this).prop("checked",true);
		}
	});

	$('#job_description').markItUp(mySettings);

	// You can add content from anywhere in your page
	// $.markItUp( { Settings } );	
	$('.add').click(function() {
 		$('#markItUp').markItUp('insert',
			{ 	openWith:'<opening tag>',
				closeWith:'<\/closing tag>',
				placeHolder:"New content"
			}
		);
 		return false;
	});
	
	// And you can add/remove markItUp! whenever you want
	// $(textarea).markItUpRemove();
	$('.toggle').click(function() {
		if ($("#markItUp.markItUpEditor").length === 1) {
 			$("#markItUp").markItUp('remove');
			$("span", this).text("get markItUp! back");
		} else {
			$('#markItUp').markItUp(mySettings);
			$("span", this).text("remove markItUp!");
		}
 		return false;
	});
})


