class AddDistrictNumToRepresentatives < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :district_num, :integer
  end
end
