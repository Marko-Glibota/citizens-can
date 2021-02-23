class RemoveFirstElectionFromRepresentative < ActiveRecord::Migration[6.0]
  def change
    remove_column :representatives, :first_election
  end
end
