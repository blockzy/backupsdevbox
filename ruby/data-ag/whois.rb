require 'whois'

w = Whois.whois("thosecurvygals.com")
t = w.technical_contact

puts t.email
