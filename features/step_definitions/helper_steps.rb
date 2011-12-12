require 'ruby-debug'

When /^I debug$/ do
  debugger; 1
end

Given /^I expect to click "([^"]*)" on a confirmation box saying "([^"]*)"$/ do |option, message|
  retval = (option == "OK") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")
  
  click_link option
end