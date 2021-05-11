class AddUserNameToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_name, :string
    add_index :articles, :user_name
  end
end
