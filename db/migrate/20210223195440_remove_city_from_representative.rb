class RemoveCityFromRepresentative < ActiveRecord::Migration[6.0]
  def change
    remove_column :representatives, :city
  end
end
