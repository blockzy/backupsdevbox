require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML(open("https://wordpress.org/support/plugin/woocommerce"))

l = doc.xpath('//tbody/tr/td/a').map { |link| link['href'] }
puts l
l.each do |page|
        doc = Nokogiri::HTML(open("#{page}"))
        puts "opened"+page
        body = doc.at('body').content
        em1 = []
        email = []
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
        body.each_line do |li|
           em1 << body.match(VALID_EMAIL_REGEX)
        end
        em1.each do |t|
          email << t.downcase
        end
        email = email.uniq
        puts "Found on #{page}: ", ""
        email.each do |a|
          puts "\t ++ #{a}", ""
        end
end

# Scrape forum for links
# Anemone each link, parse for email
