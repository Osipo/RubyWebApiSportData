#!/home/snake/.rbenv/shims/ruby
#coding:utf-8
require 'readline'
require 'net/http'
require 'json'
def errorSyntax()
	puts "Error. keyword is required."
    puts "Syntax:\n\t searchdata ={keyword}"
    puts "\t or searchdata title|url|content ={keyword}"
    puts "\t or searchdata title|url|content [[& other_attributes]...n] ={keyword_i}"
    return -1
end

def triming(ar)
	ans = []
	ar.each do |elem|
		ans.push(elem.strip)
	end
	return ans
end

def get_data_api(atr,inp)
	if atr.length == 1
		if atr.length != inp.length
			return errorSyntax
		end
		inp = triming(inp)
		url_params = {"query" => inp, "attrs" => ["title"]}
	elsif atr.length - 1 != inp.length
		return errorSyntax
	elsif atr.length > 1
		inp = triming(inp)
    	url_params = {"query" => inp, "attrs" => atr[1..-1]}
    end
	url = "http://127.0.0.1:3000/cli/articles"
    uri = URI(url)
    uri.query = URI.encode_www_form(url_params)
    
    #response = Net::HTTP.get(uri)
    #response = JSON.parse(response)
    #response = response["data"]

    puts url_params.inspect
    return url_params.inspect;
end
puts "Welcome to the CLI"
puts "Type help to view the list of available commands."
puts "Type exit to exit from the application."
while line = Readline.readline("> ")
	begin
		if line =~ /exit/i
			puts "Exit..."
			return
		end
		if line =~ /help/i
			puts "searchdata ={keyword}"
			puts "\t search data by the keyword in title"
			puts "\n searchdata title|url|content ={keyword}"
			puts "\t search data by the keyword in the indicated attribute."
			puts "\n searchdata title|url|content [[& other_attributes]...n] ={keyword_i}"
			puts "\t search data by the keyword in the indicated attributes."
			puts "\t where other_attriubets are not equal to the previous indicated."
		else
			ar = line.split("=");
			atr = ar[0].split(" ");
			
			if atr[0] !~ /searchdata/i
				puts "Command not found!"
			else
				if ar.length < 2
					errorSyntax
					next
				end
				inp = ar[1..-1]
				get_data_api(atr,inp)
			end
		end
	rescue => e
		puts e.to_s + "\n" + e.backtrace.join("\n")
	end
end
