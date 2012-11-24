class RemoveExpiredAtFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :expired_at
  end

  def down
    add_column :users, :expired_at, :datetime
  end
end
