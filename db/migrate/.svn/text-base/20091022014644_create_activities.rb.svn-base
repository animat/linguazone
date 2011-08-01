class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :available_games, :id => false do |t|
      t.references :game, :course, :teacher
      t.integer :order, :hidden
    end
  end

  def self.down
    drop_table :available_games
  end
end
