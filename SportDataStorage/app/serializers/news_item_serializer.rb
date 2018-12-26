class NewsItemSerializer < ActiveModel::Serializer
	attributes :id, :title, :content, :url
end