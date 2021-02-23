class AddDateToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :date, :string
  end
end
