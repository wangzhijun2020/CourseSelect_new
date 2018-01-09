class CreateOpensystems < ActiveRecord::Migration
  def change
    create_table :opensystems do |t|
      t.boolean :isopen
      t.timestamps null: false
    end
  end
end
