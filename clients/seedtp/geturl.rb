require 'mechanize'
require 'anemone'
require 'colorize'
a = Mechanize.new
i = 1 
$plinks = []
# Flip through 813 forum pages
while i < 814
	a.get("https://wordpress.org/support/plugin/woocommerce/page/"+i.to_s) do |page|
	    a.history.max_size = 1
# Grab each forum post link
        links = []
        
		ls = page.search('table#latest').search('tr').search('td').search('a').each {|nd| links << nd['href'] }
# Visit each link	
		links.each do |l|
# Start new thread for each link, to speed up progress			
		  Thread.new do
# Look for personal links in each forum post
                newpage = a.get(l)
                pli = []
				plink = newpage.search('div.threadpost').search('a').each {|nd| pli << nd['href'] }
			    pli.each do |pl|
				 pl = pl.split('//').last
				 pl = pl.split('/').first
				 unless pl.include? 'wordpress' or pl.include? 'packagist' or pl.include? 'woothemes' or pl.include? 'imgur' or pl.include? 'dropbox' or pl.include? 'gnu.org' or pl.include? 'github' or pl.include? 'mailto' or pl.include? '...' or pl.include? 'paypal.com' or pl.include? 'themeforest' or pl.include? 'screencast' or pl.include? 'cloudup' or pl.include? 'stackoverflow' or pl.include? 'tinyurl' or pl.include? 'woocommerce' or pl.include? 'vimeo' or pl.include? 'codecanyon' or pl.include? 'avast.com' or pl.include? 'postimg.org' or pl.include? 'php.net' or pl.include? 'google'
# Collect personal links	
                 puts pl			 
				$plinks << pl
				puts $plinks.length.red
				 end
				end
			end	
		end
        i+=1
    	puts page.uri.to_s.yellow 
	end
end	
$plinks = $plinks.uniq
num = 0
$plinks.each do |f|
    puts f.green
  begin  
	file = File.open("./urls/#{f}", 'w')
	file.puts f
	file.close
  rescue
    next
  end
end
