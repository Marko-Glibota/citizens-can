class AddTypeToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :type, :string
  end
end
