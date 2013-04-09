Then /^I should see a flash message saying "(.*?)"$/ do |message|
  page.should have_xpath XPath.descendant[XPath.attr(:class).contains(:alert)][XPath.contains(message)]
end
