class AddAuthorToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :author, :string
  end
end
