class CreateTournament < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.date :start
      t.timestamps
    end
    add_column :players, :tournament_id, :integer
    add_index :players, :tournament_id
  end
end
