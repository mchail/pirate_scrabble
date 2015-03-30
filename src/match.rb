class Match
	attr_reader :from, :to

	def initialize(from, to)
		@from = from
		@to = to
	end

	def needs
		@needs ||= @to.frequency.each_with_object({}) do |(char, count), h|
			if @from.frequency[char] < count
				h[char] = count - @from.frequency[char]
			end
		end
	end

	def needs_count
		@needs_count ||= needs.values.inject(&:+) || 0
	end

	def needs_value
		return @needs_value unless @needs_value.nil?

		@needs_value = 0
		needs.each do |char, count|
			@needs_value += Tiles[char].value * count
		end
		@needs_value
	end

	def valid?
		needs_count > 0 && !@to.contains_exact?(@from)
	end

	def sort_key
		[needs_count, needs_value, @to.to_s]
	end

	def <=>(other)
		sort_key <=> other.sort_key
	end

	def as_json
		{
			from: @from.to_s,
			to: @to.to_s,
			needs: needs,
			needsCount: needs_count,
			needsValue: needs_value
		}
	end
end
