class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :visitor_id
      t.text :full_path
      t.string :referrer

      t.timestamps
    end
  end
end
