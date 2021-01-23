class UpdateExpertiseFields < ActiveRecord::Migration[6.0]
  def change
    change_column :expertises, :name, :string, null: false
  end
end
