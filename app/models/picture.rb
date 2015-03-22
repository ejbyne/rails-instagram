class Picture < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  validates :image_file_name, presence: true
  validates :user_id, presence: true
  has_attached_file :image, :styles => { :medium => "1000x1000>", :thumb => "300x300>" },
                    :default_url => ":style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def previous
    if self == self.class.last
      self.class.first
    else
      self.class.where("id > ?", id).first
    end
  end

  def next
    if self == self.class.first
      self.class.last
    else
      self.class.where("id < ?", id).last
    end
  end

end
