class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :plan
      t.number :active_teachers
      t.number :max_teachers

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
