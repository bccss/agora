User.create(:email => '1@gmail.com', :password => '12345678', :password_confirmation => '12345678')
User.create(:email => '2@gmail.com', :password => '12345678', :password_confirmation => '12345678')
User.create(:email => '3@gmail.com', :password => '12345678', :password_confirmation => '12345678')

pizza = Food.new(:name => 'Pizza', :price => 3.99, :seller_id => 1, :seller_location => "20 McAllister St, San Francisco, CA")
pizza.image = File.new("app/assets/images/pizza.jpg")
pizza.save!

mac = Food.new(:name => 'mac', :price => 4.99, :seller_id => 2, :seller_location => "20 McAllister St, San Francisco, CA")
mac.image = File.new("app/assets/images/mac.jpg")
mac.save!