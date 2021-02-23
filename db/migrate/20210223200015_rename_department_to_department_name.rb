class RenameDepartmentToDepartmentName < ActiveRecord::Migration[6.0]
  def change
    rename_column :representatives, :department, :department_name
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
