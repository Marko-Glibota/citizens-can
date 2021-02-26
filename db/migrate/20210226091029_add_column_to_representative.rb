class AddColumnToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :slug, :string
  end
end
