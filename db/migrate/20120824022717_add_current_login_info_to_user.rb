class AddCurrentLoginInfoToUser < ActiveRecord::Migration
  def self.up    
    add_column :users, :current_login_at, :datetime
    add_column :users, :current_login_ip, :string
    add_column :users, :last_request_at, :datetime
  end

  def self.down
    remove_column :users, :current_login_at
    remove_column :users, :current_login_ip
    remove_column :users, :last_request_at
  end
end
