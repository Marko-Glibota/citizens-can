class AddDistrictRefToRepresentatives < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :district_ref, :string
  end
end
