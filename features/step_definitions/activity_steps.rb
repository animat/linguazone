Then /^there should be (\d+) "(.*?)" Game$/ do |count, activity_name|
  activity = Activity.find_by_name activity_name
  activity.games.length.should == count.to_i
end

Then /^there should be a template for "(.*?)" Game$/ do |activity_name|
  # TODO: fix this. cucumber isn't waiting for the ajax response.
  sleep 1
  activity = Activity.find_by_name activity_name
  template = Template.find_by_activity_id activity.id
  template.should_not be_nil
end
