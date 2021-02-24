class RemoveRepresentativeReferenceFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :representative, index: true
  end
end
