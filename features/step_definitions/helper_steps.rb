require 'ruby-debug'

When /^I debug$/ do
  debugger; 1
end

Then /^"([^"]*)" should not be visible$/ do |arg1|
  find(:xpath, "//*[contains(.,'#{arg1}')]").should_not be_visible
end

When /^I wait until "([^"]*)" is visible$/ do |txt|
  wait_until do
    page.should have_xpath("//*[text()='#{txt}']", :visible => true)
  end
end

When /^I wait until "([^"]*)" is not visible$/ do |txt|
  wait_until do
    page.should have_xpath("//*[text()='#{txt}']", :visible => false)
  end
end

When /^I follow the (\d+)(st|nd|rd|th) link$/ do |num, suffix|
  find(:xpath, "a[#{num}]").click
end

Given /^I expect to click "([^"]*)" on a confirmation box saying "([^"]*)"$/ do |option, message|
  retval = (option == "OK") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")
  
  click_link option
end