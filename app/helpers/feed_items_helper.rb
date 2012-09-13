module FeedItemsHelper
  def format_feed_item(show_user_name, fi)
    if fi.sourceable_type == "HighScore"
      str = display_high_score_item(show_user_name, fi)
    elsif fi.sourceable_type == "Comment"
      str = display_comment_item(show_user_name, fi)
    elsif fi.sourceable_type == "StudyHistory"
      str = display_study_item(show_user_name, fi)
    end
    str.html_safe
  end
  
  def format_feed_img(fi)
    case fi.sourceable_type
    when "HighScore"
      @activity = fi.sourceable.available_game.game.activity
      image_tag("/games/#{@activity.swf}/display/icon-small.jpg", :alt => "Play #{@activity.name}")
    when "StudyHistory"
      image_tag("word_lists/study_word_list-small.png")
    when "Comment"
      image_tag("courses/show/speech_bubble-small.jpg")
    end
  end
  
  def display_high_score_item(show_user_name, fi)
    @score = fi.sourceable.score
    @activity = fi.sourceable.available_game.game.activity
    @student = fi.sourceable.user    content = ""
    content << link_to("#{@student.display_name}", student_feed_items_path(@student)) if show_user_name
    content << format_score(show_user_name, @score, @activity)
    content << link_to("#{@activity.name}", play_path(fi.sourceable.available_game), :class => "preview_link")
    content << " "
    content << content_tag(:span, "#{format_date_time(fi.created_at)}", :class => "time_ago")
    content_tag(:p, content.html_safe)
  end
  
  def display_comment_item(show_user_name, fi)
    @student = fi.sourceable.user
    content = ""
    content << link_to("#{@student.display_name}", student_feed_items_path(@student)) if show_user_name
    content << if (show_user_name) then " recorded a " else "Recorded a " end
    content << link_to("comment", post_path(fi.sourceable.available_post), :class => "preview_link")
    content << " "
    content << content_tag(:span, "#{format_date_time(fi.created_at)}", :class => "time_ago")
    content_tag(:p, content.html_safe)
  end
  
  def display_study_item(show_user_name, fi)
    @student = fi.sourceable.user
    @study_type = fi.sourceable.study_type
    @avail_list_id = fi.sourceable.available_word_list_id
    content = ""
    content << link_to("#{@student.display_name}", student_feed_items_path(@student)) if show_user_name
    content << study_method(fi.sourceable.study_type, show_user_name)
    content << link_to("word list", url_for(:controller => "study", :action => @study_type, :id => @avail_list_id), :class => "preview_link")
    content << " "
    content << content_tag(:span, "#{format_date_time(fi.created_at)}", :class => "time_ago")
    content_tag(:p, content.html_safe)
  end
  
  def study_method(study_type, show_user_name)
    case study_type
    when "browse"
      (show_user_name) ? " browsed a " : "Browsed a "
    when "print"
      (show_user_name) ? " printed a " : "Printed a "
    when "practice"
      (show_user_name) ? " practiced a " : "Practiced a "
    when "catch"
      (show_user_name) ? " caught a " : "Caught a "
    end
  end
  
  def format_score(show_user_name, score, activity)
    display = format_high_score(score, activity.name)
    str = ""
    if display == "completed"
      str << if (show_user_name) then " completed " else "Completed " end
    else
      str << if (show_user_name) then " earned " else "Earned " end
      str << "a score of #{display} in "
    end
  end
  
  def format_feed_item_preview(fi)
    @class_name = fi.sourceable_type
    str = "<p class='preview #{@class_name}'>"
    case fi.sourceable_type
    when "HighScore"
      str << image_tag("shared-buttons/swirl_right_arrow.jpg")
      str << truncate(fi.sourceable.available_game.game.description, :length => 100, :omission => "...")
    when "StudyHistory"
      str << image_tag("shared-buttons/swirl_right_arrow.jpg")
      # TODO: Why is this breaking here? Is there any other way to manage this besides if statements? Is soft delete the only thing that can help?
      unless fi.sourceable.available_word_list.nil?
        str << truncate(fi.sourceable.available_word_list.word_list.description, :length => 100, :omission => "...")
      end
    when "Comment"
      unless fi.sourceable.content.blank?
        str << image_tag("shared-buttons/blockquote.jpg")
        str << truncate(fi.sourceable.content, :length => 100, :omission => "...")
      end
    end
    str << "</p>"
    str.html_safe
  end
end
