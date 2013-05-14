Then /^I should see the answer "(.*?)"$/ do |answer|
  page.should have_css("input[value='#{answer}']")
end

Then /^I enter "(.*?)" for node (\d+) for "(.*?)"$/ do |answer, node_number, node_name|
  page.find(".node-#{node_number.to_i - 1} .#{node_name} input").set(answer)
end

Then /^I select "(.*?)" for node (\d+) for "(.*?)"$/ do |answer, node_number, node_name|
  el = page.find(".node-#{node_number.to_i - 1} .#{node_name} select")
  page.execute_script(" $('.node-#{node_number.to_i - 1} .#{node_name} select').trigger('change')");
end

And "I add another node" do
  page.find(".addNode").click
end

When /^I fill in word list (\d+) with "(.*?)"$/ do |node_number, words|
  words = words.split(",").join("\r\n")
  page.find(".node-#{node_number.to_i - 1} textarea").set(words)
end

When /^I move to the next step for node (\d+)$/ do |node_number|
  page.find(".node-#{node_number.to_i - 1} .next").click
end

Then "my game has been created" do
  game = Game.last
  game.should_not be_nil
  game.game_data.nodes.length.should_not == 0
end
