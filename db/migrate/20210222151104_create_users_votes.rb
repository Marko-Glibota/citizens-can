class CreateUsersVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :users_votes do |t|
      t.string :voting_status
      t.references :law, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
