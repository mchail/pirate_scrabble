class Word
	attr_reader :word

	def initialize(word)
		@word = word.strip.downcase
	end

	def frequency
		@frequency ||= @word.each_char.each_with_object(Hash.new(0)) do |char, h|
			h[char] += 1
		end
	end

	def contains?(other)
		other.frequency.each do |char, count|
			if frequency[char] < count
				return false
			end
		end
		true
	end

	def contains_exact?(other)
		!@word[other.word].nil?
	end

	def to_s
		@word
	end
end
