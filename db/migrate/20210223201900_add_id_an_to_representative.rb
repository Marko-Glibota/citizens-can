class AddIdAnToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :id_an, :integer
  end
end
