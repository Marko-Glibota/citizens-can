class RenameRepresentivesVotesToRepresentativesVotes < ActiveRecord::Migration[6.0]
  def change
    rename_table :representives_votes, :representatives_votes
  end
end
