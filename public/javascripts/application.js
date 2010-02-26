$.ajaxSetup({ 
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
});

$.fn.submitWithAjax = function() {
	this.submit(function() {
		$.post(this.action, $(this).serialize(), null, "script");
		return false;
	});
	return this;
};


// Add the authenticity token to all POST-like requests, preventing XSS
$("body").bind("ajaxSend", function(elm, xhr, s) {
	if (s.type == "GET") return;
	if (s.data && s.data.match(new RegExp("\\b" + window._auth_token_name + "="))) return;
	if (s.data) {
		s.data = s.data + "&";
	} else {
	s.data = "";
	// if there was no data, $ didn't set the content-type
	xhr.setRequestHeader("Content-Type", s.contentType);
	}
	s.data = s.data + encodeURIComponent(window._auth_token_name) + "=" + encodeURIComponent(window._auth_token);
});


$(".actions.check a").click(function(){
  var $this = $(this);
  $this.hide();
  var $thisRow = $this.parents('tr:first');
  
  $thisRow.addClass("updating");
  $thisRow.append('<div class="row_ajax_status">Updating</div>');
  
  $.post(this.href, null, function(data){
	var success = data.site.last_attempt.success;
    var newText = (success) ? "Successful" : "Error";
    var newDate = data.site.last_attempted_at;
    $thisRow.find('.last_attempt_message').text(newText);
    $thisRow.find('.last_attempt_at').text(newDate);

	if (success) {
		$thisRow.addClass("success").removeClass("failure");
	} else {
		$thisRow.addClass("failure").removeClass("success");
	};

    $this.show();
    $thisRow.removeClass("updating");
    $thisRow.find('.row_ajax_status').fadeOut('fast', function(){ $(this).remove(); });
    $thisRow.effect('highlight');
  }, 'json');

  return false;
});
