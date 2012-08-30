class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :user
      t.references :course
      t.string :browser
      t.string :ip_address
      t.string :controller
      t.string :action
      t.string :params
      t.timestamps
    end
  end
end
