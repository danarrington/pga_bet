class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.date :start
      t.string :name
      t.integer :course_par
      t.timestamps
    end
    add_column :picks, :tournament_id, :integer
    add_index :picks, :tournament_id
  end
end
