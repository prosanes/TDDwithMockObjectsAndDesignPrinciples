require 'test/unit'
require_relative './alarm'

describe Alarm, "check" do
	it "should be off when initialized" do
		alarm = Alarm.new nil
		alarm.alarm_on.should be_false
	end

	context "only one check" do
		it "should be on when pressure is lower then lower limit" do
			alarm = Alarm.new create_sensor_double_with(pressure: Alarm::LOW_PRESSURE - 1)
			alarm.check.should be_true
		end

		it "should be off when pressure equals lower limit" do
			alarm = Alarm.new create_sensor_double_with(pressure: Alarm::LOW_PRESSURE)
			alarm.check
			alarm.alarm_on.should be_false
		end
		
		it "should be off when pressure between expected limits" do
			alarm = Alarm.new create_sensor_double_with(pressure: Alarm::LOW_PRESSURE + 1)
			alarm.check
			alarm.alarm_on.should be_false
		end

		it "should be off when pressure equals higher limit" do
			alarm = Alarm.new create_sensor_double_with(pressure: Alarm::HIGH_PRESSURE)
			alarm.check
			alarm.alarm_on.should be_false
		end

		it "should be on when pressure higher them high limit" do
			alarm = Alarm.new create_sensor_double_with(pressure: Alarm::HIGH_PRESSURE + 1)
			alarm.check
			alarm.alarm_on.should be_true
		end
	end

	context "multiple checks" do
		it "should be able to turn off after turning on" do
			sensor = create_sensor_double_with(pressure: Alarm::LOW_PRESSURE - 1)
			alarm = Alarm.new sensor
			alarm.check
			alarm.alarm_on.should be_true
			sensor.stub(:pop_next_pressure_psi_value).and_return(Alarm::LOW_PRESSURE + 1)
			alarm.check
			alarm.alarm_on.should be_false
		end

		it "should be able to turn on after turning off" do
			sensor = create_sensor_double_with(pressure: Alarm::LOW_PRESSURE + 1)
			alarm = Alarm.new sensor
			alarm.check
			alarm.alarm_on.should be_false
			sensor.stub(:pop_next_pressure_psi_value).and_return(Alarm::LOW_PRESSURE - 1)
			alarm.check
			alarm.alarm_on.should be_true
		end
	end


	def create_sensor_double_with(pressure: 0)
		sensorDouble = double()
		sensorDouble.stub(:pop_next_pressure_psi_value)
					.and_return(pressure)
		return sensorDouble
	end
end

