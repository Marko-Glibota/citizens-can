class AddStatusToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :status, :string
  end
end
