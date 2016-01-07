class Article < ActiveRecord::Base
	translates :title, :body
end
