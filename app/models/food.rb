class Food < ActiveRecord::Base

  belongs_to :seller, class_name: "user"
  belongs_to :buyer, class_name: "buyer"
  
  has_attached_file :image, :styles => { :medium => "300x300>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
