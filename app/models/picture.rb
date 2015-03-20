class Picture < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  validates :image_file_name, presence: true
  validates :user_id, presence: true
  has_attached_file :image, :styles => { :medium => "1000x1000>", :thumb => "200x200>" },
                    :default_url => ":style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
