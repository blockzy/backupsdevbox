require 'mechanize'
require 'anemone'
a = Mechanize.new
i = 1 
# Flip through 813 forum pages
$file = File.open('sitelist', 'a')
while i < 814
	a.get("https://wordpress.org/support/plugin/woocommerce/page/"+i.to_s) do |page|
	
# Grab each forum post link
        links = []
		ls = page.search('table#latest').search('tr').search('td').search('a').each {|nd| links << nd['href'] }
# Visit each link	
		lc = 0
		links.each do |l|
# Start new thread for each link, to speed up progress			
		Thread.new do
			sleep 3
# Look for personal links in each forum post
                newpage = a.get(l)
                pli = []
                $plinks = []
				plink = newpage.search('div.threadpost').search('a').each {|nd| pli << nd['href'] }
				 pli.each do |pl|
				 pl = pl.split('//').last
				 pl = pl.split('/').first
				 unless pl.include? 'wordpress' or pl.include? 'packagist' or pl.include? 'woothemes' or pl.include? 'imgur' or pl.include? 'dropbox' or pl.include? 'gnu.org' or pl.include? 'github' or pl.include? 'mailto' or pl.include? '...' or pl.include? 'paypal.com' or pl.include? 'themeforest' or pl.include? 'screencast' or pl.include? 'cloudup' or pl.include? 'stackoverflow' or pl.include? 'tinyurl' or pl.include? 'woocommerce' or pl.include? 'vimeo' or pl.include? 'codecanyon' or pl.include? 'avast.com' or pl.include? 'postimg.org' or pl.include? 'php.net' or pl.include? 'google'
				 
# Collect personal links	
                 puts pl			 
				 $file.puts pl
				 $file.close
				 end
				end
			end	
		end
        i+=1
    	puts page.uri.to_s 
	end
end	
def getmail
	$plinks.uniq
	$plinks.each do |l|
	a = 0
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
        email.each do |a|
          puts "++ #{a}"
        end
      rescue
        #puts "(Error, moving on)"
        next
	  end
	  end
	  a+=1
 	 end
	end
	$plinks = []
  end	
end	
getmail
