class AddUrlAnToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :url_an, :text
  end
end
