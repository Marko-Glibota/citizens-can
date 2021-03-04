class AddPhotoToLaws < ActiveRecord::Migration[6.0]
  def change
    add_column :laws, :photo, :string
  end
end
