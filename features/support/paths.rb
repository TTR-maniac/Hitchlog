module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the homepage$/
      '/'
    when /^the forgot password page/
      new_user_password_path
    when /^the login page/
      '/hitchhikers/login'
    when /^the signup page/
      '/hitchhikers/sign_up'
    when /^the profile page of (.*)$/
      user_path($1.downcase)
    when /^the hitchhikers page$/
      '/hitchhikers'
    when /^the page of this trip$/
      trip_path(Trip.last)
    when /^the edit profile page of (.*)$/
      "/hitchhikers/#{$1.downcase}/edit"
    when /^the edit trip page$/
      "/trips/#{Trip.last.to_param}/edit"
    when /^the edit page of that trip$/
      "/trips/#{Trip.last.to_param}/edit"
    when /^the future trips page$/
      future_trips_path
    when /^the tag page of (.*)$/
      "/trips/tags/#{$1.downcase}"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
