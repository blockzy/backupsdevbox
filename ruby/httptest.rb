require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'lkjsdfSDF09', :database => 'urlbrain')
i = 0
alph = ('aaa'..'zzzz').to_a
alph.each do |url|
 time = Time.now
  	sleep 0.25
  Thread.new do
    try = `curl --silent --head #{url}.com`
    i+=1
    if try.include? 'HTTP/1.1 200 OK' or try.include? 'HTTP/1.1 30'
    puts "#{url}.com"
     begin
      resp = try.split("\n")
	  client.query("INSERT INTO urls (url) VALUES ('#{url}.com')")
	 rescue
	  sleep 1
	  retry
	 end
	end
  system('clear')	
  puts i.to_s+" attempts #{time}"
  end
end
