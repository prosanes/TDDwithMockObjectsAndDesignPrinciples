require_relative './turn_number_sequence'
require_relative './turn_ticket'

class TicketDispenser
	def initialize(sequence_generator:TurnNumberSequence.instance)
		@sequence_generator=sequence_generator
	end
	
	def get_turn_ticket 
		new_turn_number = @sequence_generator.get_next_turn_number

		TurnTicket.new new_turn_number
	end
end
