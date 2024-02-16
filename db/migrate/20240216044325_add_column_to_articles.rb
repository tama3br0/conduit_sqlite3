class AddColumnToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :title, :string
    add_column :articles, :subtitle, :string
    add_column :articles, :body, :string
  end
end
