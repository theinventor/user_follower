class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :uuid

      t.timestamps
    end
  end
end
