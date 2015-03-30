require 'singleton'

class Dictionary
	include Singleton

	attr_reader :words

	def initialize
		@words = []
		File.open('/usr/share/dict/words').each_line do |line|
			line.chomp!
			word = line.strip.downcase
			if word =~ /^[a-z]+$/
				@words << Word.new(word)
			end
		end
	end

	def self.words
		self.instance.words
	end
end
