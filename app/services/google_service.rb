class GoogleService
  def self.list_places_near(current_user, place_type)
    response = get_nearby_places(current_user, place_type)
    response[:results].map { |place_data| Place.new(place_data) }
  end

  def self.convert_address_to_latlong(location)
    response = geocode(location)
    response[:results].empty? ? false : {
                                          formatted_address: response[:results][0][:formatted_address],
                                          lat_and_long: response[:results][0][:geometry][:location]
                                        }
  end

  private

  def self.conn 
    Faraday.new(url: "https://maps.googleapis.com") do |req|
      req.params[:key] = ENV['google_key']
    end
  end

  def self.geocode(location)
    response = conn.get("/maps/api/geocode/json") do |req|
      req.params[:address] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_nearby_places(current_user, type)
    response = conn.get("/maps/api/place/nearbysearch/json") do |req|
      req.params[:location] = "#{current_user.lat}, #{current_user.long}"
      req.params[:radius] = "#{current_user.radius}"
      req.params[:type] = type
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end