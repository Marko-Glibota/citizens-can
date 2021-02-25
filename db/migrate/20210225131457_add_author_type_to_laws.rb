class AddAuthorTypeToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :author_type, :string
  end
end
