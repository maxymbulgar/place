class AddAuthorEmailToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :author_email, :string
  end
end
