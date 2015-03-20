class RemoveThoughtsFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :thoughts, :string
  end
end
