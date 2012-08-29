module FeedItemsHelper
  # TODO @Len: This is basically working, but with some big flaws:
  # =>    I can't eval the fi.params to access relevant data
  # =>    Should I include a notes column on here so that I can have quick access to display data?
  # =>    Or should I be querying the database to display a preview of the comment/ game icon/ etc every time?
  def format_feed_item(fi)
    if fi.controller == "high_scores"
      str = "Earned a high score!"
    elsif fi.controller == "comments"
      str = "Recorded a "
      link = link_to "comment", "#"
      (str + link).html_safe
    elsif fi.controller == "study"
      str = study_method(fi)
      # TODO: This is causing a warning about object id... I think it's because of fi.params
      link = link_to "word list", url_for(:controller => "study", :action => fi.action, :id => fi.params.id)
      (str + link).html_safe
    end
  end
  
  def study_method(fi)
    case fi.action
    when "browse"
      "Browsed a "
    when "print"
      "Printed a "
    when "practice"
      "Practiced a "
    when "catch"
      "Caught a "
    end
  end
end
