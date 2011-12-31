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
  #TODO: Not sure how to access the icon path properly
  #TODO @Len: Too many content_tags here? Is this worth pursuing in this way? Should this be inside of another helper, not application?
  def showing_item_pic(type, item)
    if type == "game"
      content_tag(:img, "", :src => item.game.large_icon_src)
    elsif type == "word_list"
      ""
	  elsif type == "post"
	    content_tag(:img, "", :src => "courses/show/speech-bubble.jpg")
    end
  end
  
  def showing_item_header(type, item)
    content_tag(:h3, item.parent_assoc.header_text)
  end
  
  def showing_item_description(type, item)
    if type == "word_list"
      content_tag(:p, "study - options - go - here")
    else
      content_tag(:p, item.parent_assoc.description_text)
    end
  end
  
  def edit_showing_item(type, item)
    if type == "game"
      content_tag(:a, "Edit this game", :href => url_for(:controller => "customize", :action => "edit", :id => item.game.id, :cmzr_type => "game"))
    elsif type == "word_list"
      content_tag(:a, "Edit this word list", :href => url_for(:controller => "customize", :action => "edit", :id => item.word_list.id, :cmzr_type => "list"))
    elsif type == "post"
      link_to "Edit this post", edit_post_path(item.post)
    end
  end
  
  # TODO @Len: Not sure how to have a link here that will trigger JavaScript
  def hide_showing_item(type, item)
    "Hide from students"
  end
  
  def view_stats_on_showing_item(type, item, course)
    if type == "word_list"
      content_tag(:a, "View stats", :href => url_for(:controller => "study", :action => "stats", :id => item.word_list.id, :course => course.id))
    elsif type == "game"
      content_tag(:a, "View stats", :href => url_for(:controller => "play", :action => "stats", :id => item.game.id, :course => course.id))
    end
  end
end
