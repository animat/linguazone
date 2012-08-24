module FeedItemsControllerHelper
  def format_feed_item(fi)
    puts fi.to_yaml
    if fi.controller == "HighScore"
      "Earned a high score!"
    elsif fi.controller == "Comment"
      "Recorded a comment!"
    elsif fi.controller == "StudyHistory"
      "Studied a word list!"
    end
  end
end
