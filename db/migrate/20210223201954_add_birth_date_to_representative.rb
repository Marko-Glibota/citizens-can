class AddBirthDateToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :birth_date, :date
  end
end
