class ReturnDistrictFromAddress
  def initialize(address)
    address = address
    results = Geocoder.search(address)
    #Stocker ces coordonées
    @address_coordinates = results.first.coordinates
    @districts = District.all
  end

  def call
    @districts.each do |district|
      district_coordinates = eval(district.district_coordinates)
      next if district_coordinates.empty?

      polygon_coordinates = district_coordinates["coordinates"].flatten(1)
      # raise if polygon_coordinates.first.first.is_a? Array
      # if polygon_coordinates.first.first.is_a? Array
      #   polygon_coordinates = polygon_coordinates.flatten(1)
      # end
      while polygon_coordinates[0][0].is_a?(Array)
        polygon_coordinates = polygon_coordinates.flatten(1)
      end

      points = []
      polygon_coordinates.each do |coordinate|
        points << Geokit::LatLng.new(coordinate[1], coordinate[0])
      end
      polygon = Geokit::Polygon.new(points)
      if polygon.contains?(Geokit::LatLng.new(@address_coordinates[0], @address_coordinates[1]))
        return district
      end
    end
  end
end

