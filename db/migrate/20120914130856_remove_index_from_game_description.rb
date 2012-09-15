class RemoveIndexFromGameDescription < ActiveRecord::Migration
  def up
    remove_index :games, :name => "game_descrip"
  end

  def down
    add_index :games, :description
  end
end
