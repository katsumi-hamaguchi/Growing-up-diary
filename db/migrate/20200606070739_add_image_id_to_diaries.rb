class AddImageIdToDiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :image_id, :string
    add_column :diaries, :user_id, :integer, null: false, default: 0
    add_column :diaries, :is_release, :boolean, null: false, default: true
  end
end
