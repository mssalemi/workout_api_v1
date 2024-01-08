class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :title
      t.string :description
      t.string :instruction
      t.string :body_part

      t.timestamps
    end
  end
end
