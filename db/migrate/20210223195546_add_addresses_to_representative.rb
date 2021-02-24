class AddAddressesToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :addresses, :text, array: true, default: []
  end
end
