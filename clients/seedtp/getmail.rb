require 'nokogiri'
require 'anemone'

$fa = Dir.entries["./urls"] 

def getmail
	$fa.each do |l|
# new threads
    Thread.new do
	Anemone.crawl("http://#{l}") do |anemone|
     anemone.on_every_page do |page|
      unless a > 10
        page = page.url
        puts page
       begin
        doc = Nokogiri::HTML(open("#{page}"))
        body = doc.at('body').content
        em1 = []
        email = []
        #puts "(Checking text matches...)"
        body.each_line do |l|
           em1 << body.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)[0]
        end
        #puts "(Checking mailto tags...)"
        nodes = doc.xpath $sel
        em2 = nodes.collect {|n| n.value[7..-1]}
        em2.each do |i|
          email << i.downcase
        end
        em1.each do |t|
          email << t.downcase
        end
        email = email.uniq
        email.each do |e|
          file = File.open('email/'+e, 'w')
          file.puts "++ #{e}"
          file.close
        end
       rescue
        #puts "(Error, moving on)"
        next
	   end
      end
	  a+=1
 	 end
# Threads
    end 	 
	end
  end	
end	
