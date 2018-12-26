require 'json'
require 'net/http'
URL = "https://newsapi.org/v2/top-headlines?sources=the-sport-bible&apiKey=e5e296293fda42e2ba418a3a4df98b65";
module Api	
	class NewsItemsController < ActionController::Base
		# before_action :getPublic, only: [:index]
		def index
			@news_items = NewsItem.all
			render json: @news_items
		end
	end
end
