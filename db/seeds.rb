User.create(:email => '1@gmail.com', :password => '12345678', :password_confirmation => '12345678')
User.create(:email => '2@gmail.com', :password => '12345678', :password_confirmation => '12345678')
User.create(:email => '3@gmail.com', :password => '12345678', :password_confirmation => '12345678')

pizza = Food.new(:name => 'Pizza Slice', :price => 3.99, :seller_id => 1, :seller_location => "20 McAllister St, San Francisco, CA")
pizza.image = File.new("app/assets/images/pizza.jpg")
pizza.save!

mac = Food.new(:name => 'Mac & Cheese', :price => 4.99, :seller_id => 1, :seller_location => "20 McAllister St, San Francisco, CA")
mac.image = File.new("app/assets/images/mac.jpg")
mac.save!

pbandj = Food.new(:name => 'PB & J', :price => 2.99, :seller_id => 2, :seller_location => "20 McAllister St, San Francisco, CA")
pbandj.image = File.new("app/assets/images/pbandj.jpeg")
pbandj.save!

coke = Food.new(:name => 'Coca Cola', :price => 1.99, :seller_id => 3, :seller_location => "20 McAllister St, San Francisco, CA")
coke.image = File.new("app/assets/images/coke.jpg")
coke.save!

popcorn = Food.new(:name => 'Popcorn', :price => 5.99, :seller_id => 3, :seller_location => "20 McAllister St, San Francisco, CA")
popcorn.image = File.new("app/assets/images/popcorn.jpg")
popcorn.save!