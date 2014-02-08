require_relative './telemetry_diagnostic_controls'
require_relative './telemetry_client'

describe TelemetryDiagnosticControls do
	context "when connection fail" do
		it "should try to connect at least 3 times before raising error" do
			tc = double()
			tc.stub(:disconnect)
			tc.stub(:online_status).and_return(false)
			tc.should_receive(:connect).exactly(3).times
			ctrl = TelemetryDiagnosticControls.new(telemetry_client: tc)
			expect {
				ctrl.check_transmission
			}.to raise_error
		end
	end

	context "when connection succeeds" do
		it "receives the message" do
			tc = double()
			tc.stub(:disconnect)
			tc.stub(:online_status).and_return(:true)
			tc.stub(:connect)
			tc.stub(:send)
			tc.stub(:receive).and_return("expected")
			#TelemetryClient.any_instance.should_receive(:send)
			ctrl = TelemetryDiagnosticControls.new(telemetry_client:tc)
			msg = ctrl.check_transmission
			msg.should start_with("expected") 
		end
	end

end
