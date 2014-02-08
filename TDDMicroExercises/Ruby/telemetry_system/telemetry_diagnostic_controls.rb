require_relative './telemetry_client'

class TelemetryDiagnosticControls

  attr_reader :diagnostic_info

  def initialize(telemetry_client: TelemetryClient.new,
				 number_of_retries: 3)
    @telemetry_client = telemetry_client
    @diagnostic_info = ''
	@number_of_retries = number_of_retries
  end

  def check_transmission 
    @diagnostic_info = ''
    @telemetry_client.disconnect

    retry_left = @number_of_retries
    while @telemetry_client.online_status == false && retry_left > 0
      @telemetry_client.connect(DIAGNOSTIC_CHANNEL_CONNECTION_STRING)
      retry_left -= 1
    end

    if @telemetry_client.online_status == false
      raise UnableToConnect, 'Unable to connect.'
    end

    @telemetry_client.send(TelemetryClient::DIAGNOSTIC_MESSAGE)
    @diagnostic_info = @telemetry_client.receive
  end

private
  DIAGNOSTIC_CHANNEL_CONNECTION_STRING = '*111#'
end

class UnableToConnect < Exception; end
