class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.float :set_time
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
