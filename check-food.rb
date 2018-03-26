require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uri'

printf("Please enter a food: ")
food = gets.chomp.downcase

while food.empty?
	printf("Please enter a food: ")
	food = gets.chomp
end

searchURI = URI::HTTP.build(:host => "canigivemydog.com", :query => URI.encode_www_form(s: food))

page = Nokogiri::HTML(open(searchURI))
firstLink = page.css("article.first a")[0]["href"]

if not firstLink.length
	printf("#{firstLink} is empty\n")
end

foodPage = Nokogiri::HTML(open(firstLink))

answer = foodPage.css("#page h2").text.downcase

answer = answer.split("answer:")[1].lstrip.capitalize

printf("Can I give my dog %s? %s\n", food, answer)
