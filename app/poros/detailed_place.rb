class DetailedPlace
  attr_reader :place_id, :name, :hours_array, :address, :phone, :summary, :rating, :photo

  def initialize(data, photo_source)
    @place_id = data[:place_id]
    @name = data[:name]
    @hours_array = data[:current_opening_hours][:weekday_text]
    @address = data[:formatted_address]
    @phone = data[:formatted_phone_number]
    @summary = data[:editorial_summary] ? data[:editorial_summary][:overview] : "Not available"
    @rating = data[:rating]
    @photo = photo_source
  end
end