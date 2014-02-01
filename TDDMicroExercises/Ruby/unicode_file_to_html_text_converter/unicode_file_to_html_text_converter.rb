class UnicodeFileToHtmTextConverter

	def initialize(file, html_escaper)
		@file = file
		@html_escaper = html_escaper
	end

	def convert_to_html
		text = get_text_from_file
		convert_text_to_html text
	end

private

	def get_text_from_file
		if @file then
			@file.read
		else
			''
		end
	end

	def convert_text_to_html(text)
		html = ''
		text.each_line do |line|
			html += @html_escaper::escapeHTML(line)
			html += '<br />'
		end
		html
	end
end
