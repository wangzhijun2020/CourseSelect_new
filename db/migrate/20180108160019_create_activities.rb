class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :speaker
      t.string :class_room
      t.string :when
      t.timestamps null: false
    end
  end
end
