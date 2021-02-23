class AddThemeToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :theme, :string
  end
end
