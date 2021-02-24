class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :laws, :type, :source
  end
end
