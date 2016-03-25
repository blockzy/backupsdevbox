require 'ipaddress'
require 'colorize'
require 'net/http'
require 'curb'

$file = File.open('url-list', 'a')
	$fa = Dir.entries("./urls") 
	$urls = []
	u = 0
	$fa.each do |f|
	  sleep 0.5
	  Thread.new do
	  u+=1
		e = f
# Take off www
		if e.include? 'www.'
			e = e.split('www.', 2).last
		end
# Remove port from IP for validation
		if e.include? ':'
			e = e.split(':', 2).first
		end
# Remove IPs
		if IPAddress.valid? e
			$fa.delete(f)
			next
		else
		  begin
			curl = Curl::Easy.http_get(e)
            hs = curl.header_str
            
            if hs.include? "200"
				puts "#{e} : #{u}"
            else
				next
			end
		  rescue
		    next
		  end
# Commit to url array
		unless e == "." or e == ".." or e == "..."
			$urls << e
		end
# If IP statement end		
		end
# Thread end
	  end
	  puts u
# $fa.each do end	
	end
$urls.each do |ur|
	ww = `sudo whatweb #{ur}`
	ww = ww.downcase
	ww = ww.gsub(']', ' ')
	ww = ww.gsub('[', ' ')
	if ww.include? 'wordpress' or ww.include? 'woocommerce'
	puts ur.green
	$file.puts ur
	end
end
	

