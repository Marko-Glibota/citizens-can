class RemoveRegionFromRepresentative < ActiveRecord::Migration[6.0]
  def change
    remove_column :representatives, :region
  end
end
