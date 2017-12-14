class ChangeDefaults < ActiveRecord::Migration[5.1]
  def change
    change_column_default :tasks, :done, false
    change_column_default :tasks, :sort, 999999
  end
end
