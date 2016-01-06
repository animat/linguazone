Then /^I should see links for at least (\d+) games$/ do |num|
  all("tr > td > a").length.should > num.to_i
end

Then /^I should see links for (\d+) games$/ do |num|
  all("tr > td > a").length.should == num.to_i
end