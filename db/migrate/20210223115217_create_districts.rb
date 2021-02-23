class CreateDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :districts do |t|
      t.integer :department_code
      t.string :department_name
      t.integer :district_num
      t.decimal :district_coordinates

      t.timestamps
    end
  end
end
