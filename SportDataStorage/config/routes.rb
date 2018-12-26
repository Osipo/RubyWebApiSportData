Rails.application.routes.draw do
  resources :news_items
  namespace :api do
  	get "/news_items", to: "news_items#index"
  end
  get "/articles", to: "v2/articles#index"
  get "/cli/articles", to: "v2/articles#cindex"

end
