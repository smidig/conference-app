Then /^I should see an error in the form saying "(.*?)"$/ do |message|
  page.should have_xpath XPath.descendant[:form].descendant[XPath.attr(:class) == 'help-inline'][XPath.contains(message)]
end
