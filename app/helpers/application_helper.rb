# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(title)
    content_for(:title) { title }
  end
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end
  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  def format_max_teachers(max)
    if max == -1
      "unlimited teachers"
    elsif max == 1
      "one teacher"
    else
      "up to "+pluralize(max, "teacher")
    end
  end
  
  def format_cost(cost)
    cost == 0 ? "FREE" : "$"+String(cost)
  end
  
  def current_month
    Time.now().strftime '%B'
  end
  def time_since_game_created(val)
    time_ago_in_words(val)
  end
  def format_date(val)
    val.strftime '%B %e'
  end
  def format_date_with_year(val)
    val.strftime '%B %e, %Y'
  end
  def format_date_time(val)
    if val.nil?
      ""
    else
      val.strftime '%b %e at %l:%M %p'
    end
  end
  def format_short_date(val)
    val.strftime '%D' unless val.nil?
  end
  
  def hash_is_blank_except?(hash, field)
    return true if hash.nil?
    val = true
    hash.each_pair do |k, v| 
      unless k == field.to_s
        unless k == "user_id_equals"
          val = false unless v.blank?
        end
      end
    end
    val
  end
  
  def format_high_score(score, activity_name)
    activity_name
    case activity_name
      when "Leap Frog", "Mantis", "Poker Pairs", "Sentence Swiper", "Shopping"
        score+" seconds"
      when "Cliffhanger", "Bath Tub Bubbles", "Bathtub Bubbles", "Downfall", "Quiz Show"
        score+" points"
      else
        "completed"
    end
  end

  def showing_item_pic_and_link(item)
    if item.class == AvailableGame
      link_to image_tag(item.game.large_icon_src), play_path(item)
    elsif item.class == AvailableWordList
      ""
	  elsif item.class == AvailablePost
	    link_to image_tag("courses/show/speech_bubble.jpg"), post_path(item)
    end
  end
  
  def showing_item_header(item)
    content_tag(:h3, item.parent_assoc.header_text)
  end
  
  def showing_item_description(item)
    if item.class == AvailableWordList
      review_link = link_to image_tag("word_lists/review_list.jpg"), url_for(:controller => "study", :action => "browse", :id => item.id)
      print_link = link_to image_tag("word_lists/print_list.jpg"), url_for(:controller => "study", :action => "print", :id => item.id)
      study_link = link_to image_tag("word_lists/study_list.jpg"), url_for(:controller => "study", :action => "practice", :id => item.id)
      catch_link = link_to image_tag("word_lists/catch_words.jpg"), url_for(:controller => "study", :action => "catch", :id => item.id)
      
      review_link + print_link + study_link + catch_link
    else
      content_tag(:p, item.parent_assoc.description_text)
    end
  end
  
  def edit_showing_item(item)
    if item.class == AvailableGame
      link_to "Edit this game", url_for(:controller => "customize", :action => "edit", :id => item.game.id, :cmzr_type => "game")
    elsif item.class == AvailableWordList
      link_to "Edit this word list", url_for(:controller => "customize", :action => "edit", :id => item.word_list.id, :cmzr_type => "list")
    elsif item.class == AvailablePost
      link_to "Edit this post", edit_post_path(item)
    end
  end
  
  def hide_showing_item(item)
    if item.class == AvailableGame
      link_to "Hide from students", hide_game_courses_path(item), :class => "hide_available_item"
    elsif item.class == AvailableWordList
      link_to "Hide from students", hide_word_list_courses_path(item), :class => "hide_available_item"
    elsif item.class == AvailablePost
      link_to "Hide from students", hide_post_courses_path(item), :class => "hide_available_item"
    end
  end
  
  def view_stats_on_showing_item(item)
    if item.class == AvailableWordList
      link_to "View stats", url_for(:controller => "study", :action => "stats", :id => item.id)
    elsif item.class == AvailableGame
      link_to "View stats", url_for(:controller => "play", :action => "stats", :id => item.id)
    end
  end
  
  def audio_clip_s3_url(audio_id)
    if Rails.env.production?
      "https://linguazone.s3.amazonaws.com/audio/#{audio_id}.mp3"
    else
      "https://linguazone.s3.amazonaws.com/transloadit/#{audio_id}.mp3"
    end
  end
end
