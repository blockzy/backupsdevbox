# spydir is en email harvesting and keyword parsing  
# utility with modes for either direct interaction
# or automation

require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

$sel = "//a[starts-with(@href, \"mailto:\")]/@href"
$f = open("woo").read                            # We can change this something not hard coded later
$f.each_line do |url|
    begin
        page = URI.encode(url)
        doc = Nokogiri::HTML(open(page, :allow_redirections => :all))  
        body = doc.at('body').content
        em1 = []
        email = []
#        puts "(Preparing text matches...)"
        body.each_line do |l|
          begin
           em1 << body.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)[0]
          rescue
           next
          end
        end
#        puts "(Checking mailto tags...)"
        nodes = doc.xpath $sel
        em2 = nodes.collect {|n| n.value[7..-1]}
        em2.each do |i|
         begin
          email << i.downcase
		 rescue
		  next
		 end	
        end
        em1.each do |t|
         begin
          email << t.downcase
		 rescue
		  next
		 end
        end
        email = email.uniq
        email.each do |a|
          puts "++ #{a}"
        end
        rescue
         puts "ERROR"
        end
end
