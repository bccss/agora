if !(ENV["POSTMATES_API_KEY"] && ENV["POSTMATES_CUSTOMER_ID"])
  fail "Postmates keys not set (check POSTMATES_API_KEY and POSTMATES_CUSTOMER_ID)"
end

# Create a new Postmates client
$client = Postmates.new

# Set basic config variables
$client.configure do |config|
  config.api_key = ENV["POSTMATES_API_KEY"]
  config.customer_id = ENV["POSTMATES_CUSTOMER_ID"]
end