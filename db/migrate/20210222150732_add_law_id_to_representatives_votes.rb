class AddLawIdToRepresentativesVotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :representatives_votes, :law, null: false, foreign_key: true
  end
end
