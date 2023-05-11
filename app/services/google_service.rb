class GoogleService
  def initialize(current_user)
    @current_user = current_user
  end

  def search_place_by_keyword(keyword)
    response = get_place_by_keyword(keyword)
    response[:results].map { |place_data| Place.new(place_data) }
  end

  def list_nearby_places_of_type(place_type)
    response = get_nearby_places(place_type)
    response[:results].map { |place_data| Place.new(place_data) }
  end

  def convert_address_to_latlong(location)
    response = geocode(location)
    response[:results].empty? ? false : {
                                          formatted_address: response[:results][0][:formatted_address],
                                          lat_and_long: response[:results][0][:geometry][:location]
                                        }
  end

  private

  attr_reader :current_user

  def conn 
    Faraday.new(url: "https://maps.googleapis.com") do |req|
      req.params[:key] = ENV['google_key']
    end
  end

  def geocode(location)
    response = conn.get("/maps/api/geocode/json") do |req|
      req.params[:address] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_nearby_places(type)
    response = conn.get("/maps/api/place/nearbysearch/json") do |req|
      req.params[:location] = "#{current_user.lat}, #{current_user.long}"
      req.params[:radius] = "#{current_user.radius}"
      req.params[:type] = type
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_place_by_keyword(keyword)
    response = conn.get("/maps/api/place/nearbysearch/json") do |req|
      req.params[:location] = "#{current_user.lat}, #{current_user.long}"
      req.params[:radius] = "#{current_user.radius}"
      req.params[:keyword] = keyword
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end