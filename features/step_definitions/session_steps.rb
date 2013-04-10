Then /^I should be logged in$/i do
  page.should_not have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("the login page"))]
end

Then /^I should not be logged in$/i do
  expect { step %(I should be logged in) }.to raise_error
end
