module HtmlSelectorsHelpers
  def selector_for(locator)
    case locator

    when "the page"
      "html > body"
    when "the subscription's pin"
      "#pin"
    when /^the (success|notice|error) flash$/
      ".flash_#{$1}"
    when /^the available (games|word lists|word_lists|posts) area$/
      @type = $1.sub(" ", "_")
      [:xpath, "//div[@id='showing_#{@type}']"]
    
    when /^the (\d+)(st|nd|rd|th) (game|word_list|post) controls area$/
      [:xpath, "//div[@id='showing_#{$3}s']/div[#{1}]//a[@class='hide_available_item']/.."]
    
    when /^the (\d+)(st|nd|rd|th) (game|word list|post) area$/
      @num = $1
      @type = $3.sub(" ", "_")
      [:xpath, "//div[@id='showing_#{@type}s']/div[@class='available_item'][#{@num}]"]

    when /^the first search result row$/
      [:xpath, "//div[@class='wrapper']/div[@class='game_listing'][1]"]
    
    when /^the (\d+)(st|nd|rd|th) student listing$/
      @student_row = $1.to_i + 1
      [:xpath, "//table[@id='list_registrations']/tbody/tr[#{@student_row}]"]
    
    when /^the activity stream$/
      [:xpath, "//div[@id='activity_stream']"]
    
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
