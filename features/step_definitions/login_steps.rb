Given /^the following logins:$/ do |logins|
  Login.create!(logins.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) login$/ do |pos|
  visit logins_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following logins:$/ do |expected_logins_table|
  expected_logins_table.diff!(tableish('table tr', 'td,th'))
end

Given /^I am logged in as a teacher$/ do
  step %Q|I am on the teacher login page|
  step %Q|I fill in "Email address:" with "test@example.com"|
  step %Q|I fill in "Password:" with "test"|
  step %Q|I press "Login"|
  step %Q|I should see "Overview"|
end

Given /^I am logged in as "([^"]*)"$/ do |teacher_name|
  @t = User.find_by_first_name(teacher_name)
  step %Q|I am on the teacher login page|
  step %Q|I fill in "Email address:" with "#{@t.email}"|
  step %Q|I fill in "Password:" with "test"|
  step %Q|I press "Login"|
  step %Q|I should see "Overview"|
end

Given /^I am logged in as a student$/ do
  step %Q|I am on the student login page|
  step %Q|I fill in "Username or email address:" with "tony@sopranos.com"|
  step %Q|I fill in "Password:" with "badabing"|
  step %Q|I press "Login"|
  step %Q|I should see "Return to the student homepage"|
end 

Given /^I have logged out$/ do
  visit logout_path
end
