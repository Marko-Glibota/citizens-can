class AddDistrictReferenceToRepresentatives < ActiveRecord::Migration[6.0]
  def change
    add_reference :representatives, :district, null: false, foreign_key: true
  end
end
