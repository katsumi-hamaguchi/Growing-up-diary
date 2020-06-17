class CreateStacks < ActiveRecord::Migration[5.2]
  def change
    create_table :stacks do |t|
      t.integer :user_id
      t.integer :goal_id
      t.float :study_time

      t.timestamps
    end
  end
end
