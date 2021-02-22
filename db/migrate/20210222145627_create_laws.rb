class CreateLaws < ActiveRecord::Migration[6.0]
  def change
    create_table :laws do |t|
      t.integer :num
      t.text :title
      t.text :description
      t.integer :representative_id

      t.timestamps
    end
  end
end
