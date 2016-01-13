class VoteOption < ActiveRecord::Base
	has_many :votes, dependent: :destroy
	has_many :users, through: :votes
  belongs_to :poll
  validates :title, presence: true
end
