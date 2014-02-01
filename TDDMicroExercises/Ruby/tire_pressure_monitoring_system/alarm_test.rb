require 'test/unit'
require_relative './alarm'

class AlarmTest < Test::Unit::TestCase
	class SensorLowerThemLowPressure
		def pop_next_pressure_psi_value
			Alarm::LOW_PRESSURE - 5
		end
	end

	class SensorAlwaysLowPressure
		def pop_next_pressure_psi_value
			Alarm::LOW_PRESSURE
		end
	end

	class SensorBetweenLowAndHigherPressure
		def pop_next_pressure_psi_value
			Alarm::LOW_PRESSURE
		end
	end
	def test_should_be_off_when_initialized
		alarm = Alarm.new SensorLowerThemLowPressure.new
		assert !alarm.alarm_on 
	end

	def test_should_be_on_when_pressure_is_lower_then_lower_limit
		alarm = Alarm.new SensorLowerThemLowPressure.new
		assert alarm.check
	end

	def test_should_be_off_when_pressure_equals_lower_limit
		alarm = Alarm.new SensorAlwaysLowPressure.new
		assert !alarm.check 
	end

	def test_should_be_off_when_pressure_between_lower_and_higher_limit
		alarm = Alarm.new SensorBetweenLowAndHigherPressure.new
		assert !alarm.check 
	end
end
