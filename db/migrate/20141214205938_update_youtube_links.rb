class UpdateYoutubeLinks < ActiveRecord::Migration
  def up
    Activity.all.each do |activity|
      link = activity.youtube_embed.scan(/src\=\"?(.+)\?rel/)

      if link.present?
        link = link.first.first.gsub(/www\.youtube\.com\/embed\//, "youtu.be/")

        p "Setting YouTube link for #{activity.name} to #{link}..."
        activity.update_attribute "video_link", link
      end
    end
  end

  def down
  end
end
