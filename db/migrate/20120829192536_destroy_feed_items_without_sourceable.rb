class DestroyFeedItemsWithoutSourceable < ActiveRecord::Migration
  def up
    @feed_items = FeedItem.where(:sourceable_type => nil)
    @feed_items.each do |fi|
      fi.destroy
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
