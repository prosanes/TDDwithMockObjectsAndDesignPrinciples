require 'test/unit'
require_relative './alarm'

class AlarmTest < Test::Unit::TestCase
	class SensorDouble
		def pop_next_pressure_psi_value
			14
		end
	end

	def test_should_be_on_when_pressure_is_lower_then_lower_limit
		alarm = Alarm.new(SensorDouble.new)
		assert alarm.check, "Check should be true"
	end
end
