require 'rmagick'
include Magick


$colors = [
	'4F5F75', 
	'3F4B5F', 
	'B6C7DF', 
	'90A0B1', 
	'CEDDED'
]
row = 0
while row < 400
	i = 0
	c = 0
	while i<400
		f = Image.new(1,1) { self.background_color = "#"+$colors[c].to_s }
		f.write("img/#{i}.jpg")
		i+=1
		c+=1
		if c == 4
			c = 0
		end
	end
	row+=1
end	
row = 400
col = 400
ilg = ImageList.new
1.upto(col) {|x| il = ImageList.new
1.upto(row) {|y| il.push(Image.read("img/"+(y + (x-1)*col).to_s + ".jpg").first)}
ilg.push(il.append(false))}
ilg.append(true).write("out.jpg")

