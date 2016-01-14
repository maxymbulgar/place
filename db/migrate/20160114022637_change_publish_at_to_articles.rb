class ChangePublishAtToArticles < ActiveRecord::Migration
  def change
  	remove_column :articles, :publish_at, :string
  	add_column :articles, :publish_at, :datetime
  end
end
