class AddGettingStartedFieldToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :getting_started, :boolean, :default => false, :null => false
    add_index :games, :getting_started
    execute "UPDATE games set getting_started = TRUE WHERE ID = 10763"
  end

  def self.down
    remove_column :games, :getting_started
  end
end
