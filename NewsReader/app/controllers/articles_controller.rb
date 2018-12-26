require 'net/http'
require 'json'
class ArticlesController < ApplicationController
  def index
    if params[:query].present?
      fetch_articles_from_api
    end
  end

  private

  def fetch_articles_from_api
    url = "http://127.0.0.1:3000/articles"
    uri = URI(url)
    if(!params["article_filters"].present?)
      params["article_filters"] = "title" # will be added in url_params as "article_filters" => "title"
    end
    puts params["article_filters"].inspect; 
    url_params = { "query" => params[:query]}
    uri.query = URI.encode_www_form(url_params)



    @response = Net::HTTP.get(uri)
    @response = JSON.parse(@response)
    @response = @response["data"];
    puts @response.inspect;
    if(@response.is_a?(Hash))
      @response = [].push(@response); #if it has one element, returns Hash, but we have to return Array.
    end
    puts @response.inspect;
    
  end
end