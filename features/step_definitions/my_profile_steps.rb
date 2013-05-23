# encoding: UTF-8
Then /^I should have a link to my profile$/i do
  page.should have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("the my profile page"))]
end