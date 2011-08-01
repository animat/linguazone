class RemoveTimestamptsFromStates < ActiveRecord::Migration
  def self.up
    remove_column :states, :created_at
    remove_column :states, :updated_at
  end

  def self.down
    add_column :states, :updated_at, :datetime
    add_column :states, :created_at, :datetime
  end
end
