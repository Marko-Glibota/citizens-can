class ChangeDistrictCoordinatesFromDistricts < ActiveRecord::Migration[6.0]
  def change
    change_column :districts, :district_coordinates, :text
  end
end
