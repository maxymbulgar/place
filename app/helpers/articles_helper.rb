module ArticlesHelper
	def self.article_ids
	  scoped.collect(&:id).join(',')
	end
end
