module V1
	class ArticlesController < ActionController::API
		def index
			render json: news_items_collection
		end

		



		def news_items_collection
			# SELECT * FROM news_items 
			# WHERE title ISLIKE '%query%'
			# OR description ISLIKE '%query%'

			# '%#{params[:query].downcase}%'"

			# ans = NewsItem.where("LOWER(title) ILIKE :q ",{q: params[:query].downcase})
			ans = NewsItem.where("LOWER(title) ILIKE '%#{params[:query].downcase}%'");
			return ans;
		end
	end
end