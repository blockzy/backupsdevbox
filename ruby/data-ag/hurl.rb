require 'watir-webdriver'
require 'headless'

print "Enter search term (no punctuation!): "
inp = gets.chomp
print "Name of list: "
listf = gets.chomp
ext = inp.gsub(" ", "+")

h = Headless.new
h.start
$b = Watir::Browser.new 
$b.goto "https://duckduckgo.com/?q="+ext
$f = open("#{listf}", "a")
i=0
pr = 0

while i < 1000
 begin
  system "clear"
  puts "Compiling list..."
  pd = i/10.0
  puts "#{pd}% done"
  if $b.div(:id => "links").div(:id => "r1-#{i}").exists?
    linkh = $b.div(:id => "links").div(:id => "r1-#{i}").a.href     
    $f.puts linkh
  else
    $b.execute_script("window.scrollBy(0,200)")
  end
  i+=1
  rescue
 end
end    
puts "Done!"
h.destroy


