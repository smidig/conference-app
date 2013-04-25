# encoding: UTF-8
Then /^I should be logged in$/i do
  page.should_not have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("the login page"))]
end

Then /^I should not be logged in$/i do
  expect { step %(I should be logged in) }.to raise_error
end

Given /^I have just registered as a new participant$/i do
  step %(I am on the registration page)
  step %(I register as a participant with email "valid@member.com" and password "password")
end

Given /^I register as a participant with email "([^"]*)" and password "([^"]*)"$/i do |email, password|
  step %(I am on the registration page)
  step %(I fill in "#{email}" for "Epostadresse")
  step %(I fill in "Name" for "Navn")
  step %(I fill in "99009900" for "Telefon")
  step %(I fill in "#{password}" for "Password")
  step %(I check "Jeg aksepterer vilkårene")
  step %(I press "Meld meg på!")
  step %(show me the page)
  step %(I should be logged in)
end

Given(/^I am logged in as a user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  step %{I am on the login page}
  step %{I fill in "#{email}" for "user_email"}
  step %{I fill in "#{password}" for "user_password"}
  step %{I press "Sign in"}
  step %(I should be logged in)
end
