class AddIndexToVotes < ActiveRecord::Migration
  def change
  	add_index :votes, [:vote_option_id, :user_id], unique: true
  end
end
