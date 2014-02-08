require_relative './ticket_dispenser'

describe TicketDispenser do
	context "When there is only one TicketDispenser" do
		it "returns a TurnTicket with number 1" do
			td = TicketDispenser.new
			ticket = td.get_turn_ticket
			expect(ticket.turn_number).to eq(1)
		end

		it "returns sequential TurnTicket numbers" do
			td = TicketDispenser.new
			ticket1_number = td.get_turn_ticket.turn_number
			(1..3).each do
				ticket2_number = td.get_turn_ticket.turn_number
				expect(ticket1_number).to be < ticket2_number
				ticket1_number = ticket2_number
			end
		end
	end

	context "when there are multiple TicketDispenser" do
		it "Multiple ticket dispensers dont return the same TurnTicket" do
			td1 = TicketDispenser.new
			td2 = TicketDispenser.new
			
			ticket1_number = td1.get_turn_ticket.turn_number
			ticket2_number = td2.get_turn_ticket.turn_number

			expect(ticket1_number).to be < ticket2_number
		end
	end
end
