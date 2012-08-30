class ChangeFeedItemsParamsTypeToText < ActiveRecord::Migration
  def change
    change_column :feed_items, :params, :text
  end
end
