class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
