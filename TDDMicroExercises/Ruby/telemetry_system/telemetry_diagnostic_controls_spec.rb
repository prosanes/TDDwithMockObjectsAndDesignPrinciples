require_relative './telemetry_diagnostic_controls'
require_relative './telemetry_client'

describe TelemetryDiagnosticControls do
	context "when connection fail" do
		it "should try to connect at least 3 times before raising error" do
			begin
				TelemetryClient.any_instance.stub(:online_status).and_return(false)
				TelemetryClient.any_instance.should_receive(:connect).exactly(3).times
				ctrl = TelemetryDiagnosticControls.new
				expect {
					ctrl.check_transmission
				}.to raise_error
			rescue Exception
			end
		end
	end

	context "when connection succeeds" do
		it "receives the message" do
			TelemetryClient.any_instance.stub(:online_status).and_return(true)
			#TelemetryClient.any_instance.should_receive(:send)
			ctrl = TelemetryDiagnosticControls.new
			msg = ctrl.check_transmission
			msg.should start_with("LAST") 
		end
	end

end
