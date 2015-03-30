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
		}
	});

	function getSuggestions(word) {
		$.get('/make-from', {word: word}, function(data) {
			$suggestions.empty();
			$.each(data.suggestions, function(index, suggestion) {
				needs = [];
				$.each(suggestion.needs, function(chr, count) {
					for (var _ = 0; _ < count; _++) {
						needs.push(chr);
					}
				});
				needs.sort();
				var text = suggestion.to + " (needs " + needs.join(', ') + ")";
				var $suggestion = $('<div>').addClass('suggestion').text(text);
				$suggestions.append($suggestion);
			});
		});
	}
});