require 'singleton'

class Dictionary
	include Singleton

	attr_reader :words

	def initialize
		@words = []
		File.each_line('/usr/share/dict/words') do |line|
			line.chomp!
			@words << Word.new(line)
		end
	end
end
