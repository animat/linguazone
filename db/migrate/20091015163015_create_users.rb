class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.string :email
      t.string :password
      t.date :expire_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
