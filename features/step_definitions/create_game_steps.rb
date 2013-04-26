Then /^I should see the answer "(.*?)"$/ do |answer|
  page.should have_css("input[value='#{answer}']")
end

Then /^I enter "(.*?)" for node (\d+) for "(.*?)"$/ do |answer, node_number, node_name|
  page.find(".node-#{node_number.to_i - 1} .#{node_name} input").set(answer)
end

And "I add another node" do
  page.find(".addNode").click
end
