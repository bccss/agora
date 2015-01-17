class Transaction < ActiveRecord::Base
  
  belongs_to :seller, class_name: "user"
  belongs_to :buyer, class_name: "buyer"
  belongs_to :food

end
