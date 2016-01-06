class AvailableItemsUseBooleanForHidden < ActiveRecord::Migration
  def up
    change_column :available_posts, :hidden, :boolean
    change_column :available_word_lists, :hidden, :boolean
  end

  def down
    change_column :available_posts, :hidden, :integer
    change_column :available_word_lists, :hidden, :integer
  end
end
