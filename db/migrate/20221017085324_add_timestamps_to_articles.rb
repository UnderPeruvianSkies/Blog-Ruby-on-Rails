class AddTimestampsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :article_created_at, :datetime
    add_column :articles, :article_updated_at, :datetime
  end
end
