class AddIdAnToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :id_an, :string
  end
end
