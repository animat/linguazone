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

When /^I follow "([^"]*)" and click OK$/ do |text|
  page.evaluate_script("window.alert = function(msg) { return true; }")
  page.evaluate_script("window.confirm = function(msg) { return true; }")
  step %{I follow "#{text}"}
end
