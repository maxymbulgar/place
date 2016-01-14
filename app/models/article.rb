class Article < ActiveRecord::Base
	translates :title, :body
	has_many :comments, dependent: :destroy
	#sd
end
