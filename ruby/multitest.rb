
require 'open-uri'
a = 'http://www.example.com ' * 30
arr = a.split(' ')

arr.each_slice(3) do |group|
  group.map do |site|
    Thread.new do
      open(site)
      p 'finished'
    end
  end.each(&:join)
end

