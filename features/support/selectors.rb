module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def selector_for(locator)
    case locator

    when "the page"
      "html > body"
    when "the subscription's pin"
      "#pin"
    when /^the (success|notice|error) flash$/
      ".flash_#{$1}"
    when /^the (\d+)(st|nd|rd|th) game area$/
      [:xpath, "//div[@id='showing_games']/div[@class='available_item'][#{$1}]"]
    when /^the (\d+)(st|nd|rd|th) post area$/
      [:xpath, "//div[@id='showing_posts']/div[@class='available_item'][#{$1}]"]
    when /^the (\d+)(st|nd|rd|th) word list area$/
      [:xpath, "//div[@id='showing_word_lists']/div[@class='available_item'][#{$1}]"]
    when /^the first search result row$/
      [:xpath, "//div[@class='wrapper']/div[@class='game_listing'][1]"]
    when /^the wrapper$/
      ".wrapper"
    # TODO @Len: Can I capture "word list" and use Ruby to force into "word_list"?
    when /^the (game|word_list|post) header section$/
      [:xpath, "//div[@id='#{$1}_header']"]
      

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #  when /^the (notice|error|info) flash$/
    #    ".flash.#{$1}"

    # You can also return an array to use a different selector
    # type, like:
    #
    #  when /the header/
    #    [:xpath, "//header"]

    # This allows you to provide a quoted selector as the scope
    # for "within" steps as was previously the default for the
    # web steps:
    when /^"(.+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)
