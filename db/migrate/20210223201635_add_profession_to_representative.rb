class AddProfessionToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :profession, :string
  end
end
