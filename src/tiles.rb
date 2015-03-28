require 'singleton'

class Tiles
	include Singleton

	def initialize
		@tiles = {}
		lines = File.readlines('./config/tiles')
		lines.shift
		lines.each do |line|
			line.chomp!
			letter, value, count = line.split
			@tiles[letter] = Letter.new(value.to_i, count.to_i)
		end
	end
end

class Letter < Struct.new(:value, :count)
end
