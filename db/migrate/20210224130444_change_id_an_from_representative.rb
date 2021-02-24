class ChangeIdAnFromRepresentative < ActiveRecord::Migration[6.0]
  def change
    change_column :representatives, :id_an, :string
  end
end
