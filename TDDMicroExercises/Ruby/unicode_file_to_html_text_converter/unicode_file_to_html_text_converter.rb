require 'cgi'

class UnicodeFileToHtmTextConverter

	def initialize(file_path)
		@file_path = file_path
	end

	def convert_to_html
		text = get_text_from_file_path
		convert_text_to_html text
	end

private

	def get_text_from_file_path
		if @file_path and File.exists? @file_path then
			file = File.open(@file_path)
			file.read
		else
			''
		end
	end

	def convert_text_to_html(text)
		html = ''
		text.each_line do |line|
			html += CGI::escapeHTML(line)
			html += '<br />'
		end
		html
	end
end
