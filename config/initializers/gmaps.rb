# Create the API endpoint for the Google Maps javascript source
if ENV["GMAPS_API_KEY"].present?
  GMAPS_API_URL = "https://maps.googleapis.com/maps/api/js?key=#{ENV["GMAPS_API_KEY"]}"
else
  fail "No google maps API Key found!"
end
