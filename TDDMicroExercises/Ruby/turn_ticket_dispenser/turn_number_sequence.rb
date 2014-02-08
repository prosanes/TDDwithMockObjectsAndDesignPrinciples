
require 'singleton'

class TurnNumberSequence
	include Singleton

	def initialize(initial_number: 0)
		@turn_number = initial_number
	end

	def get_next_turn_number
		@turn_number += 1
	end
end
