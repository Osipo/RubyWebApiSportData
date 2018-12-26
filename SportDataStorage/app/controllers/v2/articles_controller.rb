require_relative "../../helpers/DateHelpers/dateparsing.rb"
require_relative "../../helpers/JsonHelpers/jsonextracter.rb"
module V2
	class ArticlesController < ActionController::API
		before_action :load, only:[:index]

		def index
			render json: news_items_collection
		end

		#Console
		def cindex
			render json: news_items_collection_attr
		end

		private
		def load
			d = DateHelpers::DateNotifyer.new;
			if(!File.exists?("app/data") || !File.directory?("app/data"))
				Dir.mkdir("app/data") # OR FileUtils.mkdir_p 'nested_dir'  (FileUtils in module fileutils)
			end
			d.checkDate("app/data/input"); 
			if(d.getNotification())
				data = JsonHelpers.getDataByUrl(JsonHelpers::URL);
				data.each do |doc|
					arguments = {"title" => doc["title"],"content" => doc["content"],"url" => doc["url"]};
					el = NewsItem.new(arguments);
					el.save;
				end
			end
		end



		def news_items_collection
			# SELECT * FROM news_items 
			# WHERE title ISLIKE '%query%'
			# OR description ISLIKE '%query%'

			# '%#{params[:query].downcase}%'"

			# ans = NewsItem.where("LOWER(title) ILIKE :q ",{q: params[:query].downcase})
			title = params["article_filters"];
			ans = NewsItem.where("LOWER('%#{title}%') ILIKE '%#{params[:query].downcase}%'");
			return ans;
		end

		#Console
		def news_items_collection_attr
			a = params["attrs"]
			q = ""
			a.each do |elem|
				q+= elem.downcase.inspect
				q+= " = ? AND"
			end
			q = q[0...-3].to_s #delete AND keyword.
			ans = "";
			if a.length == 1
				ans = NewsItem.where(q,params[:query][0].downcase)
			elsif a.length == 2
				ans = NewsItem.where(q,params[:query][0].downcase,params[:query][1].downcase)
			elsif a.length == 3
				ans = NewsItem.where(q,params[:query][0].downcase,params[:query][1].downcase,params[:query][2].downcase)
			else
				#Error
			end
			return ans
		end
	end
end