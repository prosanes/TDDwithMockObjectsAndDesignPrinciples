require 'test/unit'
require_relative './unicode_file_to_html_text_converter'

describe UnicodeFileToHtmTextConverter, "" do

	it "creates an empty html when not receiving a file" do
		html = converted_html_from_file_content_given_path(nil)
		html.should eq ""
	end

	it "creates an empty html when receiving an invalid path" do
		html = converted_html_from_file_content_given_path('/invalid_path')
		html.should eq ""
	end

	it "converts an empty file to an empty html" do
		html = converted_html_from_file_content_given_path('./fixtures/empty_file.txt')
		html.should eq ""
	end

	it "creates a <br> tag for each line" do
		html = converted_html_from_file_content_given_path('./fixtures/file_with_two_lines.txt')
		html.scan("<br />").count.should eq 2
	end

	it "escapes special characters" do
		html = converted_html_from_file_content_given_path('./fixtures/file_with_special_chars.txt')
		html.should eq "Usage: foo &quot;bar&quot; &lt;baz&gt; &amp;\n<br />"
	end

	def converted_html_from_file_content_given_path(path)
		converter = UnicodeFileToHtmTextConverter.new(path)
		html = converter.convert_to_html
	end
end

