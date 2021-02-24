class RenamePartyToPartyAcronym < ActiveRecord::Migration[6.0]
  def change
    rename_column :representatives, :party, :party_acronym
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
