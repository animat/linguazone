Then /^I should see the answer "(.*?)"$/ do |answer|
  page.should have_css("input[value='#{answer}']")
end
