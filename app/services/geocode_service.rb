class GeocodeService
  def self.conn 
    Faraday.new(url: "https://maps.googleapis.com") do |req|
      req.params[:key] = ENV['google_key']
    end
  end

  def self.get_url(url, location)
    response = conn.get(url) do |req|
      req.params[:address] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.convert_address_to_latlong(location)
    response = get_url("/maps/api/geocode/json", location)
    response[:results].empty? ? false : {
                                          formatted_address: response[:results][0][:formatted_address],
                                          lat_and_long: response[:results][0][:geometry][:location]
                                        }
  end
end