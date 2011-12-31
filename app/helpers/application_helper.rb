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
end
