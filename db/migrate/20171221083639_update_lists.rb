class UpdateLists < ActiveRecord::Migration[5.1]
  def change
    #add_column :lists, :user_id, :integer
    add_reference :lists, :user, foreign_key: true
  end
end
