class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :type
      t.references :expertise, null: true, foreign_key: true

      t.timestamps
    end
  end
end
