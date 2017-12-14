class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :list, index: true
      t.string :title
      t.boolean :done
      t.integer :sort

      t.timestamps
    end
  end
end
