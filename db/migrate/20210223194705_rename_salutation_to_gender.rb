class RenameSalutationToGender < ActiveRecord::Migration[6.0]
  def change
    rename_column :representatives, :salutation, :gender
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
