class RemoveCirconscriptionRefFromRepresentatives < ActiveRecord::Migration[6.0]
  def change
    remove_column :representatives, :circonscription_ref, :string
  end
end
