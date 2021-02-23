class CreateDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :districts do |t|
      t.integer :department_code
      t.string :department_name
      t.integer :district_num
      t.string :district_coordinates
      t.geometry :representative_id

      t.timestamps
    end
  end
end
