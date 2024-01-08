class AddImgUrlToExercises < ActiveRecord::Migration[7.0] # The version number may vary
  def change
    add_column :exercises, :img_url, :string
  end
end
