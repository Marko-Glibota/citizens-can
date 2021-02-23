class RenameRepresentativeRefToDepartmentCode < ActiveRecord::Migration[6.0]
  def change
    rename_column :representatives, :representative_ref, :department_code
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
