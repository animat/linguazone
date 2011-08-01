class RemoveTimestampsFromStates < ActiveRecord::Migration
  def self.up
    remove_column :states, :created_at
    remove_column :states, :updated_at
  end

  def self.down
    add_column :updated_at, :states, :datetime
    add_column :created_at, :states, :datetime
  end
end
