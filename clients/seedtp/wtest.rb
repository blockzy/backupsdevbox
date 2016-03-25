require 'watir'
require 'headless'

h = Headless.new
#h.start
$b = Watir::Browser.new

def getlinks(pg)
	$b.goto pg
  begin
	links2 = $b.div(:class => 'post').as.to_a
    puts links2
	links2.each do |l|
     unless links1[li].include? 'wordpress.org' or links1[li].include? 'stackoverflow' or links1[li].include? 'paypal.com'
      puts l.text
      li+=1
     end
	end
  rescue
  end
end
i=1

while i < 814
	$b.goto "https://wordpress.org/support/plugin/woocommerce/page/#{i}"
 begin
	links1 = $b.table(:id => 'latest').links.to_a
    li = 3
    while li < links1.length
      puts links1
      getlinks(links1[li].href)
      li+=1
    end
 i+=1
 rescue
  i+=1
  next
 end
end
h.destroy


=begin
doc = Nokogiri::HTML(open("https://wordpress.org/support/topic/change-add-to-cart-button-in-category-to-product-description-1"))

links = doc.at_xpath('//ol/li/div/div/p/a').map { |link| link['href'] }
puts links
=end
