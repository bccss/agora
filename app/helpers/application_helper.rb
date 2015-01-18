module ApplicationHelper

  class PostmatesWrapper

    def self.quote(seller_location, buyer_location)
      $client.quote(pickup_address: seller_location, dropoff_address: buyer_location)
    end

    def self.delivery(package)
      $client.create(package)
    end

  end
end
