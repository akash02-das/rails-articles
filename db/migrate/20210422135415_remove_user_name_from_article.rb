class RemoveUserNameFromArticle < ActiveRecord::Migration[6.1]
  def change
    remove_index :articles, :user_name
    remove_column :articles, :user_name, :string
  end
end
