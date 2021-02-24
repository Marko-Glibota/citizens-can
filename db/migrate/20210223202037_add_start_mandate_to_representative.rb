class AddStartMandateToRepresentative < ActiveRecord::Migration[6.0]
  def change
    add_column :representatives, :start_mandate, :date
  end
end
