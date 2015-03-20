class RemoveNamesFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :name, :string
  end
end
