class CreateActivityTable < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :name, :swf
      t.text :help
      t.integer :convertable
    end
  end

  def self.down
    drop_table :activities
  end
end
