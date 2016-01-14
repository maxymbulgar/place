class AddPublishAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :publish_at, :string
  end
end
