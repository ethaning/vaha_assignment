class UpdateExerciseFieldsDefaultValues < ActiveRecord::Migration[6.0]
  def change
    change_column :exercises, :name, :string, null: false
    change_column :exercises, :duration, :integer, default: 0, null: false

    add_index :exercises, :name, unique: true
  end
end
