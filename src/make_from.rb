# Get suggestions to steal a word

class MakeFrom
	def initialize(word)
		@word = Word.new(word)
	end

	def suggestions
		Dictionary.words.find_all do |word|
			word.contains?(@word)
		end.map do |word|
			Match.new(@word, word)
		end.find_all(&:valid?).sort
	end
end
