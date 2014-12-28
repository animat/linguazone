class AddCounterCacheToMediaCategory < ActiveRecord::Migration
  def up
    add_column :media_categories, :media_count, :integer, :null => false, :default => 0

    MediaCategory.all.each do |category|
      category.media_count = category.medias.count
      p "#{category.to_s} has #{category.medias.count} medias"
      category.save!
    end
  end

  def down
    remove_column :media_categories, :media_count
  end
end
