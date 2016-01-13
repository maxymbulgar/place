class Poll < ActiveRecord::Base
	has_many :vote_options, dependent: :destroy
	validates :topic, presence: true
	accepts_nested_attributes_for :vote_options

	def normalized_votes_for(option)
	  votes_summary == 0 ? 0 : (option.votes.count.to_f / votes_summary) * 100
	end
	
	def votes_summary
	  vote_options.inject(0) {|summary, option| summary + option.votes.count}
	end
end
