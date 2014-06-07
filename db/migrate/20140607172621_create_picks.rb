class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.belongs_to :user
      t.belongs_to :player
      t.string :tournament
      t.timestamps
    end
  end
end
