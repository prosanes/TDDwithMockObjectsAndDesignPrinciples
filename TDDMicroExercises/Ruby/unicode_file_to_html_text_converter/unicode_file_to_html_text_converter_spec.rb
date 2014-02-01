require 'test/unit'
require 'cgi'
require_relative './unicode_file_to_html_text_converter'

describe UnicodeFileToHtmTextConverter, "" do

	it "creates an empty html when not receiving a file" do
		converter = UnicodeFileToHtmTextConverter.new(nil, double())
		html = converter.convert_to_html
		html.should eq ""
	end

	it "converts an empty file to an empty html" do
		converter = get_converter_with(path: './fixtures/empty_file.txt')
		html = converter.convert_to_html
		html.should eq ""
	end

	it "creates a <br> tag for each line" do
		html_escaper = double()
		html_escaper.stub(:escapeHTML).and_return('')
		converter = get_converter_with(path: './fixtures/file_with_two_lines.txt', html_escaper: html_escaper)
		html = converter.convert_to_html
		html.scan("<br />").count.should eq 2
	end

	it "invokes @html_escaper::escapeHTML(line) for each line" do
		html_escaper = double()
		expect(html_escaper).to receive(:escapeHTML).twice.and_return('')
		converter = get_converter_with(path: './fixtures/file_with_two_lines.txt', html_escaper: html_escaper)
		html = converter.convert_to_html
	end

	def get_converter_with(path: '', html_escaper: double())
		file = File.open(path)
		converter = UnicodeFileToHtmTextConverter.new(file, html_escaper)
	end

end

