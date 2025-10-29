class ChangeNullInLinks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :links, :title, false
    change_column_null :links, :url, false
  end
end
