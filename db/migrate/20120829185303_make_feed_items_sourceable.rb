class MakeFeedItemsSourceable < ActiveRecord::Migration
  def change
    add_column :feed_items, :sourceable_type, :string
    add_column :feed_items, :sourceable_id, :integer
  end
end
