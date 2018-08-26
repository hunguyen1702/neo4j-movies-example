class AddColumnToRate < ActiveRecord::Migration
  def change
    add_column :rates, :comment, :text
    add_column :rates, :star, :integer
  end
end
