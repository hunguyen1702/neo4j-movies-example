class AddTypeColumnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :type, :integer
  end
end
