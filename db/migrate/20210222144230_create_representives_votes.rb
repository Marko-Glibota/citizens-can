class CreateRepresentivesVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :representives_votes do |t|
      t.references :representative, null: false, foreign_key: true
      t.string :voting_status

      t.timestamps
    end
  end
end
