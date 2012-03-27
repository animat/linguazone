module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the student login page/
      '/students/login'
    when /the pricing page/
      pricing_path
    when /the new trial page/
      '/trial'
    when /the teachers page/
      teachers_path
    when /the teacher login page/
      login_teachers_path
    when /the about features page/
      about_features_path
    when /^the "([^"]*)" course page$/
      course_path(Course.find_by_name($1))
    when /^the ([^"]*) demos page$/
      @lang = Language.where(:name => $1).first
      url_for(:controller => "about", :action => "demos", :language => @lang.id)
    when /^the media category index api$/
      api_media_categories_path
    when /^the show game [0-9] api$/
      api_v1_game_path($1)



    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
