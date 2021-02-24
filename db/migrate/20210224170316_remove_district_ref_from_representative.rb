class RemoveDistrictRefFromRepresentative < ActiveRecord::Migration[6.0]
  def change
    remove_column :representatives, :district_ref
  end
end
