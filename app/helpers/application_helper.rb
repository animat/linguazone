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
  #TODO: Not accessing game icons properly
  def showing_item_pic_and_link(type, item)
    if type == "game"
      link_to image_tag(item.game.large_icon_src), play_path(item.game)
    elsif type == "word_list"
      ""
	  elsif type == "post"
	    link_to image_tag("courses/show/speech_bubble.jpg"), post_path(item.post)
    end
  end
  
  def showing_item_header(type, item)
    content_tag(:h3, item.parent_assoc.header_text)
  end
  
  def showing_item_description(type, item)
    if type == "word_list"
      review_link = link_to image_tag("word_lists/review_list.jpg"), url_for(:controller => "study", :action => "browse", :id => item.word_list.id)
      print_link = link_to image_tag("word_lists/print_list.jpg"), url_for(:controller => "study", :action => "print", :id => item.word_list.id)
      study_link = link_to image_tag("word_lists/study_list.jpg"), url_for(:controller => "study", :action => "practice", :id => item.word_list.id)
      catch_link = link_to image_tag("word_lists/catch_list.jpg"), url_for(:controller => "study", :action => "catch", :id => item.word_list.id)
      
      review_link + print_link + study_link + catch_link
    else
      content_tag(:p, item.parent_assoc.description_text)
    end
  end
  
  def edit_showing_item(type, item)
    if type == "game"
      link_to "Edit this game", url_for(:controller => "customize", :action => "edit", :id => item.game.id, :cmzr_type => "game")
    elsif type == "word_list"
      link_to "Edit this word list", url_for(:controller => "customize", :action => "edit", :id => item.word_list.id, :cmzr_type => "list")
    elsif type == "post"
      link_to "Edit this post", edit_post_path(item.post)
    end
  end
  
  # TODO @Len: Not sure how to have a link here that will trigger JavaScript
  def hide_showing_item(item)
    unless item.class == AvailablePost
      link_to "Hide from students", hide_game_courses_path(item), :class => "hide_available_item"
    end
  end
  
  def view_stats_on_showing_item(type, item, course)
    if type == "word_list"
      link_to "View stats", url_for(:controller => "study", :action => "stats", :id => item.word_list.id, :course => course.id)
    elsif type == "game"
      link_to "View stats", url_for(:controller => "play", :action => "stats", :id => item.game.id, :course => course.id)
    end
  end
end
