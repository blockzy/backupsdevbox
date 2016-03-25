require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'lkjsdfSDF09', :database => 'urlbrain')

oct1 = 192
oct2 = 210
oct3 = 198
oct3 = 10

while oct3 < 255
    try = `curl --silent --head -m 10 192.210.198.#{oct3.to_s}`
    if try.include? 'HTTP/1.1 200 OK' or try.include? 'HTTP/1.1 30'
     begin
      resp = try.split("\n")
	  client.query("INSERT INTO urls (url) VALUES ('192.210.198.#{oct3.to_s}')")
	 rescue
	  sleep 1
	  retry
	 end
	
	  puts oct3
	  resp.each do |t|
		if t.include? "Link:"
		 puts t
		end
	  end
	end
	oct3+=1
end



