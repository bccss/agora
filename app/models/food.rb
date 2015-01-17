class Food < ActiveRecord::Base

  belongs_to :seller, class_name: "user"
  belongs_to :buyer, class_name: "buyer"

end
