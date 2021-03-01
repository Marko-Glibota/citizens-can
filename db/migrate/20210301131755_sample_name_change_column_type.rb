class SampleNameChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    remove_column :laws, :date, :string
    add_column :laws, :date, :date
  end
end
