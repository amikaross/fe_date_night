class GoogleService
  def initialize(current_user)
    @current_user = current_user
  end

  def search_place_by_keyword(keyword)
    response = get_place_by_keyword(keyword)
    response[:results].map { |place_data| Place.new(place_data) }
    # TO DO: Do not include result if type is "premise" OR if business status is != "OPERATIONAL"
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

  def get_place_by_id(id)
    response = get_place(id)
    photo_reference = response[:result][:photos][0][:photo_reference]
    DetailedPlace.new(response[:result], get_photo(photo_reference))
  end

  private

  attr_reader :current_user

  def get_photo(photo_reference)
    response = conn.get("/maps/api/place/photo") do |req|
      req.params[:photo_reference] = photo_reference
      req.params[:maxwidth] = 400
    end

    response.headers["location"]
  end

  def conn 
    Faraday.new(url: "https://maps.googleapis.com") do |req|
      req.params[:key] = ENV['google_key']
    end
  end

  def get_place(id)
    response = conn.get("/maps/api/place/details/json") do |req|
      req.params[:place_id] = id
    end

    JSON.parse(response.body, symbolize_names: true)
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