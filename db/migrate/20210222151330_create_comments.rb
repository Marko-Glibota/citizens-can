class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :title
      t.text :content
      t.string :voting_status
      t.references :user, null: false, foreign_key: true
      t.references :law, null: false, foreign_key: true

      t.timestamps
    end
  end
end
