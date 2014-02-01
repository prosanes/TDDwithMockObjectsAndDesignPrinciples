require_relative './sensor'

class Alarm

  attr_reader :alarm_on

  def initialize(sensor)
    @sensor = sensor
    @alarm_on = false
  end

  def check
    pressure = @sensor.pop_next_pressure_psi_value()

	if pressure < LOW_PRESSURE || HIGH_PRESSURE < pressure then
		@alarm_on = true
	else
		@alarm_on = false
	end
  end

private

  LOW_PRESSURE = 17
  HIGH_PRESSURE = 21
end
