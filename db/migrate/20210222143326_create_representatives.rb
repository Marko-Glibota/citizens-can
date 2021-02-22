class CreateRepresentatives < ActiveRecord::Migration[6.0]
  def change
    create_table :representatives do |t|
      t.string :first_name
      t.string :last_name
      t.string :salutation
      t.string :email
      t.string :circonscription_ref
      t.string :circonscription_num
      t.string :city
      t.string :department
      t.string :region
      t.string :party
      t.string :representative_ref
      t.boolean :first_election
      t.integer :hemicycle_seat

      t.timestamps
    end
  end
end
