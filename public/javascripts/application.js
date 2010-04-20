
// Set jQuery up so respond_to works correctly for ajax calls 
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};


// It's surprisingly tricky to stick a cursor at the end of a textarea
// in a cross-platform manner
jQuery.fn.focusAtEnd = function() {
    return this.each(function() {
        $(this).focus()

        if (this.setSelectionRange) { // Everything but IE
        	var len = $(this).val().length;
	        this.setSelectionRange(len, len);
        }
        else { // IE
        	$(this).val($(this).val());
        }
    });
};

$(document).ready(function() {
  $("#new_historic_tweet").submitWithAjax();
});

// Put '@username' at the head of any text in the tweet box, move cursor to end for ease of typing
function reply_to(user_name) {
	$("#tweet_content").val('@' + user_name + ' ' + $("#tweet_content").val());
	$("#tweet_content").focusAtEnd();
}