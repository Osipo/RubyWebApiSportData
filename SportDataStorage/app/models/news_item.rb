class NewsItem < ApplicationRecord
	validates :title, length: {in: 8..255} #in: Range, is: Equal, minimum, maximum
	validates :title, presence: true
	validates :content, presence: true
	validates :id, uniqueness: true
end