$(document).ready(function() {
	var $input = $('input');
	var $letters = $('.letters');
	var $suggestions = $('.suggestions');
	$input.on('input', function() {
		$letters.empty();
		$input.val(
			$input.val().toLowerCase().replace(/[^a-z]/g, '')
		);
		var word = $input.val();
		var letters = word.split('');
		$.each(letters, function(index, letter) {
			var $letter = $('<span>').addClass('letter').text(letter);
			$letter.css('left', index * 100 + 'px');
			$letters.append($letter);
		});
		if (word.length >= 4) {
			getSuggestions(word);
		} else {
			$suggestions.empty();
		}
	});

	function getSuggestions(word) {
		$.get('/make-from', {word: word}, function(data) {
			if (word !== $input.val()) {
				return;
			}
			$suggestions.empty();
			$.each(data.suggestions, function(index, suggestion) {
				needs = [];
				$.each(suggestion.needs, function(chr, count) {
					for (var _ = 0; _ < count; _++) {
						needs.push("<span class='letter small-letter'>" + chr + "</span>");
					}
				});
				needs.sort();
				var html = "<a href='http://en.wiktionary.org/wiki/" +
					suggestion.to +
					"' target='_blank'>" +
					suggestion.to +
					"</a> (needs " +
					needs.join(', ') +
					")";
				var $suggestion = $('<li>').addClass('suggestion').html(html);
				$suggestions.append($suggestion);
			});
			if (data.suggestions.length === 0) {
				$suggestions.text("No results found!");
			}
		});
	}
});
