require 'mysql2'
require 'whois'
Process.daemon
client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'lkjsdfSDF09', :database => 'data')
begin
	file = File.open("list").read
	rescue
	  sleep 10
	  retry
end
	list = []
	file.each_line do |l|
	list << l.chomp
	end
	i=0
	x = 1
	while x < 4
		list = list.to_a.permutation(x).map(&:join)
		list.each do |url|
			sleep 0.1
			time = Time.now
			Thread.new do
				try = `curl --silent --head -m 5 #{url}.com`
				i+=1
				if try.include? 'HTTP/1.1 200 OK'
					w = Whois.whois("#{url}.com")
					t = w.technical_contact
					puts url
					begin
						client.query("INSERT INTO sites (url, owner_name, owner_email) VALUES ('#{url}.com', '#{t.name}', '#{t.email}')")
					rescue
						sleep 1
						retry
					end
				end
			end
		end
		x+=1
	end	

