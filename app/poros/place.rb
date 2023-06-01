class Place
  attr_reader :name, :place_id
  
  def initialize(place_data)
    @name = place_data[:name]
    @place_id = place_data[:place_id]
    @rating = place_data[:rating]
    @vicinity = place_data[:vicinity]
  end
end