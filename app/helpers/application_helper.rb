module ApplicationHelper

  class PostmatesWrapper

    def self.quote(seller_location, buyer_location)
      $client.quote(pickup_address: seller_location, dropoff_address: buyer_location)
    end

    def self.delivery
     package = {
              manifest: "a box of kittens",
              pickup_name: "The Warehouse",
              pickup_address: "20 McAllister St, San Francisco, CA",
              pickup_phone_number: "555-555-5555",
              pickup_business_name: "Optional Pickup Business Name, Inc.",
              pickup_notes: "Optional note that this is Invoice #123",
              dropoff_name: "Alice",
              dropoff_address: "101 Market St, San Francisco, CA",
              dropoff_phone_number: "415-555-1234",
              dropoff_business_name: "Optional Dropoff Business Name, Inc.",
              dropoff_notes: "Optional note to ring the bell"
              #quote_id: "dqt_K9LFfpSZCdAJsk" # optional
            }
      @delivery = $client.create(package)
    end

  end
end
