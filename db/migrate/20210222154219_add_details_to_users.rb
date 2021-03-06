class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :zip, :string
    add_column :users, :city, :string
    add_column :users, :age, :integer
    add_reference :users, :representative, null: false, foreign_key: true
  end
end
