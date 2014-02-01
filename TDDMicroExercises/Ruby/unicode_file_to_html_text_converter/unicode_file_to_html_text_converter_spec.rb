require 'test/unit'
require_relative './unicode_file_to_html_text_converter'

describe UnicodeFileToHtmTextConverter, "" do

	it "creates an empty html when not receiving a file" do
		converter = UnicodeFileToHtmTextConverter.new(nil)
		html = converter.convert_to_html
		html.should eq ""
	end

	it "creates an empty html when receiving an invalid path" do
		converter = UnicodeFileToHtmTextConverter.new('/invalid_path')
		html = converter.convert_to_html
		html.should eq ""
	end

	it "converts an empty file to an empty html" do
		converter = UnicodeFileToHtmTextConverter.new('./fixtures/empty_file.txt')
		html = converter.convert_to_html
		html.should eq ""
	end

	it "creates a <br> tag for each line"

	it "escapes special characters"
end

