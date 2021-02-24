class RenameHemicycleSeatToSeatNumber < ActiveRecord::Migration[6.0]
  def change
    rename_column :representatives, :hemicycle_seat, :seat_number
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
