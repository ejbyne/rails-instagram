class Comment < ActiveRecord::Base
  belongs_to :picture
  validates :thoughts, length: { minimum: 3, maximum: 150 }
end
