class AddCollaboratorsToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :collaborators, :string, array: true, default: []
  end
end
