class RemoveContentFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :content, :string
  end
end
