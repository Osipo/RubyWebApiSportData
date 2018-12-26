#coding:utf-8
require 'json'
require 'net/http'
module JsonHelpers
	URL = "https://newsapi.org/v2/top-headlines?sources=the-sport-bible&apiKey=e5e296293fda42e2ba418a3a4df98b65";
	articles = [];
	def JsonHelpers.getDataByUrl(url)
		uri = URI(url)
		response = Net::HTTP.get(uri)
		json = JSON.parse(response)
		return json["articles"]
	end
end