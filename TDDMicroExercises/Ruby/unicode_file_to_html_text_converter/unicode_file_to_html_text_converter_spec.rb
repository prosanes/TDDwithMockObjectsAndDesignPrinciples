require_relative './unicode_file_to_html_text_converter'

describe UnicodeFileToHtmTextConverter, "" do

	context "object", type: :unit do
		it "creates an empty html when not receiving a file" do
			converter = UnicodeFileToHtmTextConverter.new(nil, double())
			html = converter.convert_to_html
			html.should eq ""
		end

		it "converts an empty file to an empty html" do
			converter = get_converter_with(file_content: '')
			html = converter.convert_to_html
			html.should eq ""
		end

		it "creates a <br> tag for each line" do
			html_escaper = double()
			html_escaper.stub(:escapeHTML).and_return('')

			file_content = "line 1\n" +
						   "line 2"

			converter = get_converter_with(file_content: file_content, html_escaper: html_escaper)

			html = converter.convert_to_html
			html.scan("<br />").count.should eq 2
		end

		it "invokes @html_escaper::escapeHTML(line) for each line" do
			html_escaper = double()
			expect(html_escaper).to receive(:escapeHTML).twice.and_return('')

			file_content = "line 1\n"\
						   "line 2"

			converter = get_converter_with(file_content: file_content, html_escaper: html_escaper)
			html = converter.convert_to_html

			#expectation done
		end
	end

	def get_converter_with(file_content: '', html_escaper: double())
		file = double()
		allow(file).to receive(:read).and_return(file_content)
		converter = UnicodeFileToHtmTextConverter.new(file, html_escaper)
	end

	context "integration", type: :integration do
		it "works correctly with File and CGI dependencies" do
			u = UnicodeFileToHtmTextConverter.build('./fixtures/file_with_two_lines.txt')
			t = u.convert_to_html
			t.scan('<br />').count.should eq 2
		end
	end

end

