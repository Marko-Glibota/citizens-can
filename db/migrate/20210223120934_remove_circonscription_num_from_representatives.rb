class RemoveCirconscriptionNumFromRepresentatives < ActiveRecord::Migration[6.0]
  def change
    remove_column :representatives, :circonscription_num, :string
  end
end
