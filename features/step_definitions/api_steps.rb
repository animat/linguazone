Then /^the XML response should have "([^"]*)" with the text "([^"]*)"$/ do |xpath, text|
  parsed_response = Nokogiri::XML(page.body)
  elements = parsed_response.xpath(xpath)
  elements.should_not be_empty, "could not find #{xpath} in:\n#{page.body}"
  elements.find { |e| e.text == text }.should_not be_nil, "found elements but could not find #{text} in:\n#{elements.inspect}"
end

Then /^the XML response should not have "([^"]*)"$/ do |xpath|
  parsed_response = Nokogiri::XML(page.body)
  elements.should be_empty, "did not expect to find #{xpath} in:\n#{page.body}"
end

Then /^the XML response should not have "([^"]*)" with the text "([^"]*)"$/ do |xpath, text|
  parsed_response = Nokogiri::XML(page.body)
  elements = parsed_response.xpath(xpath)
  elements.find { |e| e.text == text }.should be_nil, "did find #{text} in:\n#{elements.inspect}"
end
