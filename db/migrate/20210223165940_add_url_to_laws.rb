class AddUrlToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :url, :text
  end
end
